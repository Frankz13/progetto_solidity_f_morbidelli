// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SalesLib.sol";
import "./Types.sol";

// Contratto per la gestione di un negozio di prodotti online
contract CourseCommerceManager{

    address public owner;
    uint256 public totalSales;
    uint256 public currentProductID;
    uint256 public currentSaleId;

    using Types for Types.Product;
    using Types for Types.Sale;

    Types.Product[] public products;
    Types.Sale[] public sales;


    // Creazione Eventi per tracciare nuovi prodotti e nuove vendite
    event NewSaleAdded (uint256 saleId, address buyerAddress, uint256 saleDate, uint256 saleProductId, uint256 totalSales);
    event NewProductAdded (uint256 productId, string productName, uint256 productPrice);

    // Costruttore che inizializza lo stato del contratto
    constructor()
    {
        owner = msg.sender;
        totalSales = 0;
        currentProductID = 0;
        currentSaleId = 1000000;
    }

    // Modificatore per limitare l'accesso solo all'owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Funzione per aggiungere un prodotto
    function addProduct(string memory _productName, uint256 _productPrice) public onlyOwner{
        currentProductID ++;
        Types.Product memory newProduct = Types.Product({
            productId: currentProductID,
            productAddress: msg.sender,
            productName: _productName,
            productPrice: _productPrice
        });

        products.push(newProduct);
        emit NewProductAdded(currentProductID, _productName, _productPrice);
    }

    // Funzione per comprare un prodotto
    function buyProduct(uint256 _productId) public payable{
        require(_productId > 0 && _productId <= currentProductID, "Product does not exist.");

        Types.Product memory product = products[_productId - 1];

        require(msg.value >= product.productPrice, "Not enough Ether to purchase the product");

        uint256 change = msg.value - product.productPrice;
        

        Types.Sale memory newSale = Types.Sale({
            saleId: ++currentSaleId,
            buyerAddress: msg.sender,
            saleDate: block.timestamp,
            saleProductId: _productId,
            sellerAddress: payable(product.productAddress),
            salePrice: product.productPrice
        });

        sales.push(newSale);
        totalSales ++;

        if (change > 0){
            payable(msg.sender).transfer(change);
        }
        emit NewSaleAdded(currentSaleId, msg.sender, block.timestamp, _productId, totalSales);
    }

    // Funzione per il prelievo dei fondi da parte dell'owner
    function ownerWithdraw(uint256 amount) public onlyOwner{
        require(amount <= address(this).balance, "Not enough found in the smart contract balance");
        payable(owner).transfer(amount);
    }

    // Funzione per ottenere i dettagli di un prodotto
    function getProductDetails(uint _productId) public view returns (uint256, address, string memory, uint256){
        require(_productId > 0 && _productId <= currentProductID, "Product does not exist.");
        Types.Product memory product = products[_productId - 1];
        return (product.productId, product.productAddress, product.productName, product.productPrice);
    }

    // Funzione per ottenere i dettagli di una vendita
    function getSaleDetails(uint256 _saleId) public view returns (uint256, address, uint256, address, uint256, string memory, uint256){
        require(_saleId > 1000000 && _saleId <= currentSaleId, "Sale order does not exist.");
        Types.Sale memory sale = sales[_saleId - 1000001];
        Types.Product memory product = products[sale.saleProductId - 1];
        return (sale.saleId, sale.buyerAddress, sale.saleDate, sale.sellerAddress, product.productId, product.productName, product.productPrice);
    }

    // Funzione per ottenere gli acquisti di un cliente
    function getUserSales(address customer) public view returns (Types.Product[] memory) {
        return SalesLib.getUserSales(customer, sales, products);
    }

    function getSalesAmountInPeriod(uint256 _from, uint256 _to) public view returns (uint256) {
        return SalesLib.getSalesAmountInPeriod(sales, _from, _to);
    }

    
}
