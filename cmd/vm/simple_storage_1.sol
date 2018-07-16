pragma solidity ^0.4.0;

contract simple_storage_1 {
    uint storedData=23;
    
    event getLog(address addr, string message);
    event getLog1(string message);
    event getLog2(string message);

    function set(uint x) public{
        getLog1("set getLog1");
        getLog2("set getLog2");
        storedData=x;
    }
    
    function get() constant public returns(uint) {
        getLog(msg.sender, "get getLog");
        getLog1("get getLog1");
        set(16);
        return storedData;
    }
}