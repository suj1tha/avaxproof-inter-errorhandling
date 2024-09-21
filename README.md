# Metacrafters ETH + AVAX PROOF: Intermediate EVM Course - Error Handling using Book Lending Contract

This Solidity project represents a basic book lending library system implemented as a smart contract. It allows users to add books to the library, borrow books by updating the number of available copies, and return books, managing the copies each user has borrowed.

## Description

The BookLending contract is designed to manage a collection of books where each book is identified by a unique ID. Users can add books to the system, borrow available copies, and return them. The contract utilizes `require`, `assert`, and `revert` to ensure the integrity of transactions and state consistency. This project serves as a functional prototype for a decentralized library system on the Ethereum blockchain.

## Getting Started

### Prerequisites

- Install an Ethereum wallet like MetaMask to interact with the contract.
- Use an IDE like Remix IDE for deploying and testing the contract.

### Installation

1. **Clone the repository:**
   ```
   git clone https://github.com/yourgithub/booklending.git
   ```
2. **Navigate to the project directory:**
   ```
   cd booklending
   ```

### Executing Program

1. **Open Remix IDE:**
   Go to [Remix IDE](https://remix.ethereum.org/) and upload the `BookLending.sol` file.

2. **Compile the contract:**
   Select the Solidity compiler version `0.8.20` and compile the contract.

3. **Deploy the contract:**
   - In the "Deploy & Run Transactions" pane, choose the compiled `BookLending` contract.
   - Click "Deploy" to deploy the contract on Ethereum testnet (e.g., Rinkeby).

4. **Interact with the contract:**
   - Use the deployed contract functions (`addBook`, `borrowBook`, `returnBook`) to manage books and transactions.

## Help

If you encounter any issues:
- Make sure you have sufficient testnet ETH for transaction fees.
- Check that you are using a compatible compiler version (`^0.8.20`).

## Authors

Sujitha

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
