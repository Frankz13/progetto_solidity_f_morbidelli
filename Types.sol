// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Types {

    struct Product{
        uint256 productId;
        address productAddress;
        string productName;
        uint256 productPrice;
    }

    struct Sale{
        uint256 saleId;
        address buyerAddress;
        address payable sellerAddress;
        uint256 saleDate;
        uint256 saleProductId;
        uint256 salePrice;
    }
}