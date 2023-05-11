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
        address payable sellerAddress;
        uint256 saleDate;
        Product saleProduct;

    }


    Product[] public products;
    Sale[] public sales;

    constructor()
    {
        owner = msg.sender;
        totalSales = 0;
        currentProductID = 0;
        currentSaleId = 0;
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


    function buyProduct(uint256 _productId) public payable{ 
        // Verifica se il prodotto esiste
        require(_productId > 0 && _productId <= currentProductID, "Product does not exist." );

        // Recupera il prodotto
        Product memory product = products[_productId - 1];

        // Verifica se l'utente ha abbastanza Ether per acquistare il prodotto
        require(msg.value >= product.productPrice, "Not enough Ether to purchase the product");

        // Calcola il resto 
        uint256 change = msg.value - product.productPrice;

        // Crea un record di vendita e aggiungilo all'array sales
        Sale memory newSale = Sale({
            saleId: ++currentSaleId,
            buyerAddress: msg.sender,
            saleDate: block.timestamp,
            saleProduct: product,
            sellerAddress: payable(product.productAddress)            
        });        
        sales.push(newSale);

        // Trasferisci l'Ether al venditore
        newSale.sellerAddress.transfer(product.productPrice);

        // Restituisci il resto all' utente
        if (change > 0){
            payable(msg.sender).transfer(change);
        }

    }

}