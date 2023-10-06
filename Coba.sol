// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

contract Coba {
    struct Book {
        string ISBN;
        string title;
        uint256 year;
        string author;
    }

    mapping(string => Book) private books;
    address private admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function addBook(string memory _ISBN, string memory _title, uint256 _year, string memory _author) public onlyAdmin {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(books[_ISBN].ISBN).length == 0, "ISBN already exists");

        books[_ISBN] = Book(_ISBN, _title, _year, _author);
    }

    function updateBook(string memory _ISBN, string memory _title, uint256 _year, string memory _author) public onlyAdmin {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(books[_ISBN].ISBN).length > 0, "ISBN does not exist");

        books[_ISBN] = Book(_ISBN, _title, _year, _author);
    }

    function deleteBook(string memory _ISBN) public onlyAdmin {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(books[_ISBN].ISBN).length > 0, "ISBN does not exist");

        delete books[_ISBN];
    }

    function getBookByISBN(string memory _ISBN) public view returns (string memory, string memory, uint256, string memory) {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(books[_ISBN].ISBN).length > 0, "ISBN does not exist");

        Book memory book = books[_ISBN];
        return (book.ISBN, book.title, book.year, book.author);
    }

    // function setScore ()....
    fallback() external { 

    }

    receive() external payable { 
        // function untuk menerima ether
    }
}