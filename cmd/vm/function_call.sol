pragma solidity ^0.4.0;
import * as symbolName from "./simple_storage.sol";

contract Consumer {
    symbolName.SimpleStorage s;
    
    function setSimpleStorage(address addr) public{
        s = symbolName.SimpleStorage(addr);
    }
    
    function callSimpleStorageGet() public returns (uint ret) {
        return s.get() + 1;
    }
    
    function callSimpleStorageSet(uint x) public {
        s.set(x);
    }
}