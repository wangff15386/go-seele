pragma solidity ^0.4.18;

// File: contracts\Datamarket.sol

contract Datamarket {
    // 合约拥有者
    address Owner;
    // 控制合约映射表
    mapping(string => address) contracts;

    // 限定指定人修改数据
    modifier checkOwner() {
        require(msg.sender == Owner);
        _;
    }

    // 构造方法
    function Datamarket() public
    {
        Owner = msg.sender;
    }

    // 根据名字获取合约地址
    function getContract(string name) public view returns (address addr)
    {
        addr = contracts[name];
    }

    // 设置名字 - 合约地址映射
    function setContract(string name, address addr) public checkOwner
    {
        // 合约拥有者有修改权限
        contracts[name] = addr;
    }
}
