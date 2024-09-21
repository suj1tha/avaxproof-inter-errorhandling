// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BookLending {
    struct Book {
        string title;
        uint copiesAvailable;
    }

    mapping(uint256 => Book) public books;
    mapping(uint256 => mapping(address => uint)) public borrowerCopies;
    uint256 public totalBooks;

    event BookAdded(uint256 bookId, string title, uint copies);
    event BookBorrowed(uint256 bookId, address borrower, uint copies);
    event BookReturned(uint256 bookId, address borrower, uint copies);

    function addBook(string memory title, uint copies) public {
        require(copies > 0, "At least one copy is required.");
        uint256 bookId = totalBooks++;
        books[bookId] = Book(title, copies);
        emit BookAdded(bookId, title, copies);
    }

    function borrowBook(uint256 bookId, uint numCopies) public {
        books[bookId].copiesAvailable -= numCopies;
        borrowerCopies[bookId][msg.sender] += numCopies;
        emit BookBorrowed(bookId, msg.sender, numCopies);

        assert(books[bookId].copiesAvailable >= 0);
    }

    function returnBook(uint256 bookId, uint numCopies) public {
        uint borrowedCopies = borrowerCopies[bookId][msg.sender];
        if (borrowedCopies < numCopies) {
            revert("Trying to return more copies than borrowed.");
        }

        books[bookId].copiesAvailable += numCopies;
        borrowerCopies[bookId][msg.sender] -= numCopies;
        emit BookReturned(bookId, msg.sender, numCopies);

        assert(borrowerCopies[bookId][msg.sender] >= 0);
    }
}
