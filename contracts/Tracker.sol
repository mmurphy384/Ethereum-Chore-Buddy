pragma solidity ^0.4.8;

import "Chores.sol";
import "Users.sol";
import "ConvertLib.sol";

contract Owned {
    address public owner;

    function Owned() {
        owner = msg.sender;
    }
}

contract Tracker is Users, Chores {
    
    Users users;
    
    function Tracker() {
                
    }
    
    function addPerson(bytes16 _nickName, address _address) {
        //users.add(_nickName, _address);
    }
    
    function getPerson(address _address) constant returns (bytes16) {
        //if (!users[_address]) throw;

    }    

}