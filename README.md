# CourseCommerceManager

This repository contains a Solidity smart contract for an online product store. The smart contract, CourseCommerceManager, allows users to add products to the store, purchase products, and view details about sales and products.

## Features

- **Product Management**: The contract owner can add products to the store. Each product has an ID, an associated Ethereum address, a name, and a price.
- **Sales Management**: Users can purchase available products using Ether. Each sale is logged with a unique ID, the buyer's address, the sale date, and the product's ID.
- **Sales Reporting**: The contract provides functionality for retrieving details about sales and products. Users can view the products they've purchased.
- **Sales Analytics**: The contract includes functionality to calculate the total sales amount in Ether over a specific period.

## Getting Started

To interact with this contract, you will need an Ethereum development environment, like Truffle, installed.

### Installing

1. Clone this repository to your local machine.

```bash
git clone https://github.com/<your-github-username>/CourseCommerceManager.git
```


2. Navigate to the project directory.

```bash
cd CourseCommerceManager
```
## Running the Tests
To run the contract tests:
1.Compile the contract.
```bash
truffle compile
```
2.Run the tests.
```bash
truffle test
```
## Deploying the Contract
To deploy the contract to a local Ethereum network:

1. Start a local Ethereum node.

```bash 
ganache-cli
```

2.Migrate the contract.
```bash
truffle migrate
```
## Built With
* Solidity - Ethereum's smart contract programming language.
* Truffle - A development framework for Ethereum.


## Contributing
We welcome contributions from the community. Please submit your pull requests.

License
This project is licensed under the MIT License.
