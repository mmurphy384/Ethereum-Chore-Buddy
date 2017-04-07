pragma solidity ^0.4.8;

contract Users {
    
    User[] users;
    mapping (address => uint) addressBook;
    address public owner;

    struct User {
        bytes16 nickName;
        uint balance;
        bytes1 isActive;
        address wallet;
        uint id;
    }

    modifier isOwner () {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }

    // Constructor
    function Users(address _owner) {
        owner = _owner;
    }


    // functions
    function addUser(bytes16 _nickName, address _address) returns (bool success) {
        User memory u;
        u.nickName = _nickName;
        u.balance = 0;
        u.isActive = "Y";
        u.wallet = _address;
        users.push(u);
        // link the address book to the users array
        addressBook[_address] = users.length;
        return true;
    }


    function getPersonBalance(bytes16 nickName) constant returns (uint) {

    }

    // TO-DO:  Add IsOwner modifier    
    function getUsers() isOwner constant returns (bytes16[], uint[]) {

        // need a counter to initialize the arrays
        uint numUsers = users.length;
        
        // good times with bytes
        bytes16[] memory nickNames = new bytes16[](numUsers);
        uint[] memory balances = new uint[](numUsers);
        
        for (uint i = 0; i < users.length; i++) {
            if (users[i].isActive == "Y") {
                User memory currentUser;
                currentUser = users[i];
                nickNames[i] = currentUser.nickName;
                balances[i] = currentUser.balance;
            }
        }
        return (nickNames, balances);
    }
    
}