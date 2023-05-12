// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductSaleDefination{

     // Struttura per rappresentare un prodotto
    struct Product{
        uint256 productId;
        address productAddress;
        string productName;
        uint256 productPrice;
    }

    // Struttura per rappresentare una vendita
    struct Sale{
        uint256 saleId;
        address buyerAddress;
        address payable sellerAddress;
        uint256 saleDate;
        uint256 saleProductId;
    }
}