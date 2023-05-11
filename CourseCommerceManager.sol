// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CourseCommerceManager{

    address public owner;
    uint256 public totalSales;
    uint256 public currentProductID;
    uint256 public currentSaleId;
    
    struct Product{
        uint256 productId;
        address productAddress;
        string productName;
        uint256 productPrice;
        
    }
    
    struct Sale{
        uint256 saleId;
        address buyerAddress;
        uint256 saleDate;
        //Product saleProduct;

    }


    Product[] public products;
    Sale[] public sales;

    constructor()
    {
        owner = msg.sender;
        totalSales = 0;
        currentProductID = 1000000;
        currentSaleId = 1000000;
    }

    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }

    function addProduct(string memory _productName, uint256 _productPrice) public onlyOwner{
        currentProductID ++;
        Product memory newProduct = Product({
            productId: currentProductID,
            productAddress: msg.sender,
            productName: _productName,
            productPrice: _productPrice
        });

        products.push(newProduct);

    }


    function buyProduct() public{
        currentSaleId ++;
        totalSales ++;
        Sale memory newSale = Sale({
            saleId: currentSaleId,
            saleDate: block.timestamp,
            buyerAddress: msg.sender
        });
        
        sales.push(newSale);

    }

}