
# 🛍️ CourseCommerceManager: Solidity Smart Contract for Online Product Sales 📚

## 🎯 Introduction

Welcome to `CourseCommerceManager`, an Ethereum smart contract written in Solidity, serving as a foundational e-commerce platform. As the contract owner, you can list products for sale 🏷️, and buyers can purchase these products by sending the appropriate amount of Ether 💰.

## 🔧 Technical Decisions

### 🔑 Contract Ownership
The contract utilizes the `onlyOwner` modifier for specific functions, limiting access to only the contract's owner (the address that deployed the contract). This is a common pattern for contracts that require administrative privileges for certain actions.

```solidity
modifier onlyOwner {
    require(msg.sender == owner);
    _;
}
```

### 📚 Data Structures
The primary data structures in this contract are the `Product` and `Sale` structs. They represent the products for sale and the record of sales, respectively. They're stored in array data structures to facilitate listing and retrieval of products and sales.

```solidity
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
}
```

### 📣 Events
The contract emits `NewSaleAdded` and `NewProductAdded` events upon the addition of new products and sales. These events enable off-chain services and user interfaces to react to changes in the contract state in real-time.

```solidity
event NewSaleAdded (uint256 saleId, address buyerAddress, uint256 saleDate, uint256 saleProductId, uint256 totalSales);
event NewProductAdded (uint256 productId, string productName, uint256 productPrice);
```

### 📚 Libraries
The `SalesLib` and `Types` libraries are crucial components of this contract, providing modularization and enabling the reuse of common functions across multiple contracts. These libraries handle tasks ranging from retrieving user sales to calculating the total sales amount within a given period.

```solidity
using Types for Types.Product;
using Types for Types.Sale;
```

### 💰 Ether Management
The contract includes a `buyProduct` function, allowing users to buy products by sending Ether to the contract. Additionally, the contract owner can withdraw Ether from the contract using the `ownerWithdraw` function.

```solidity
function buyProduct(uint256 _productId) public payable{
    // ...
    payable(msg.sender).transfer(change);
}

function ownerWithdraw(uint256 amount) public onlyOwner{
    payable(owner).transfer(amount);
}
```

### ❗ Error Handling
The contract uses `require` statements for error handling, ensuring conditions like sufficient balance, product existence, and ownership are met.

```solidity
require(_productId > 0 && _productId <= currentProductID, "Product does not exist.");
require(msg.value >= product.productPrice, "Not enough Ether to purchase the product");
require(amount <= address(this).balance, "Not enough found in the smart contract balance");
```

## 🚀 Future Improvements

While the current implementation provides a robust foundation for an e-commerce smart contract, it could be expanded with more complex features, such as a shopping cart 🛒 for bulk purchases, discount codes, or even a full auction system 🛎️. Stay tuned for further developments.
