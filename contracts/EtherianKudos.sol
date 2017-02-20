pragma solidity ^0.4.1;

import "BasicCoin.sol";
import "Lockable.sol";

contract EtherianKudos is BasicCoin{

    event TokenMint(address minter, address beneficiary, string data);
    event NewMinter(address minter, address newMinter);

    // storage of minting reason
	struct Receipt {  
		address minter;
		address beneficiary;
		string data;
	}

    mapping (address => bool) public minters;
	
	// the balance should be available
	modifier when_minter(address _minter) {
		if (!minters[_minter]) throw;
		_;
	}

	// the base, tokens denoted in micros
	uint constant public base = 0;

	// storage and mapping of minting receipts
    mapping (uint => Receipt) public receipts;


	// constructor sets the parameters of execution, _totalSupply is all units
	function EtherianKudos(address _minter) BasicCoin(1,_minter) {
		_add_minter(0x0,_minter);
		_mint(0x0,_minter,"Developer");
	}

    function mint(address _beneficiary,string _data) when_minter(msg.sender){
		totalSupply++;
		accounts[_beneficiary].balance++;
		_mint(msg.sender,_beneficiary,_data);
    }

    function setMinter(address _newMinter) when_minter(msg.sender){
        _add_minter(msg.sender, _newMinter);
    }
    
    function _mint(address _minter, address _beneficiary,string _data) internal{
        receipts[totalSupply].minter = _minter;
        receipts[totalSupply].beneficiary = _beneficiary;
        receipts[totalSupply].data = _data;
        TokenMint(_minter, _beneficiary, _data);
    }
    
    function _add_minter(address _minter, address _newMinter) internal{
        minters[_newMinter] = true;    
        NewMinter(_minter,_newMinter);
    }
}