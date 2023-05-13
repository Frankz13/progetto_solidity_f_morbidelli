// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Types.sol";

library SalesLib {
    using Types for Types.Product;
    using Types for Types.Sale;

    function getUserSales(address customer, Types.Sale[] storage sales, Types.Product[] storage products) public view returns (Types.Product[] memory) {
        Types.Product[] memory customerProducts = new Types.Product[](sales.length);
        uint256 count = 0;
    
        for(uint i = 0; i < sales.length; i++) {
            if(sales[i].buyerAddress == customer) {
                for(uint j = 0; j < products.length; j++) {
                    if(products[j].productId == sales[i].saleProductId) {
                        customerProducts[count] = products[j];
                        count++;
                        break;
                    }
                }
            }
        }

        // Rimuovere gli spazi vuoti dell'array
        Types.Product[] memory result = new Types.Product[](count);
        for(uint i = 0; i < count; i++) {
            result[i] = customerProducts[i];
        }
        return result;
    }

        function getSalesAmountInPeriod(Types.Sale[] storage sales, uint256 _from, uint256 _to) external view returns(uint256)
    {
        uint256 totalSalesInPeriod = 0;
        for (uint i = 0; i < sales.length; i++){
            if(sales[i].saleDate >= _from && sales[i].saleDate <= _to) {
                totalSalesInPeriod += sales[i].salePrice;

            }
        }
        return totalSalesInPeriod;
    }
}