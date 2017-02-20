pragma solidity ^0.4.1;

// ECR20 standard token interface
contract Token {
	event Transfer(address indexed from, address indexed to, uint256 value);
	event Approval(address indexed owner, address indexed spender, uint256 value);

	function balanceOf(address _owner) constant returns (uint256 balance);
	function transfer(address _to, uint256 _value) returns (bool success);
	function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
	function approve(address _spender, uint256 _value) returns (bool success);
	function allowance(address _owner, address _spender) constant returns (uint256 remaining);
}