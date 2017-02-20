pragma solidity ^0.4.1;

contract Owned{
    event NewOwner(address indexed old, address indexed current);
    address public owner = msg.sender;
    
    modifier only_owner(){
        if (msg.sender != owner) throw; _;
    }
    
    function setOwner(address _newOwner) only_owner{
        if(_newOwner == 0x0) throw;
        NewOwner(owner,_newOwner);
        owner = _newOwner;
    }
    
}