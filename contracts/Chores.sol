pragma solidity ^0.4.8;

contract Chores {
    
	// TO DO: change to arrays (I think)
    mapping (bytes8 => Chore) public chores;
    address owner;

    bytes3 paymentCurrency;

    // Constructor    
    function Chores(bytes2 _currency) {
        paymentCurrency = _currency;
    }
    
    struct Chore {
        uint payAmount;
        uint expiresOn;
    }

	function setOwner(address _owner) {
		owner = _owner;
	}

    function addChore(bytes8 _name, uint _paymentAmount, uint _expiresOn) {
        Chore memory c = Chore(_paymentAmount,_expiresOn);
        chores[_name] = c;
    }

}