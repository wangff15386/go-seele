pragma solidity ^0.4.0;

contract SimpleStorage {
    uint storedData;

    function SimpleStorage(uint x) public{
        storedData = x;
    }

    function set(uint x) payable public {
        storedData = x;
    }

    function get() payable public returns (uint) {
        return storedData;
    }
}