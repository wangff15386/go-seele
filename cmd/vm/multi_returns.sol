pragma solidity ^0.4.0;

contract MultiReturns {

    function arithmetics(uint _a, uint _b) pure public returns (uint o_sum, uint o_product) {
        o_sum = _a + _b;
        o_product = _a * _b;
    }

    function arithmetics1(uint _a, uint _b) pure public returns (uint[]) {
        uint o_sum = _a + _b;
        uint o_product = _a * _b;
        uint[] memory a = new uint[](2);
        a[0]=o_sum;
        a[1]=o_product;
        return a;
    }
}