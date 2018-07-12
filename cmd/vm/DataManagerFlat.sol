pragma solidity ^0.4.18;

// File: contracts\libraries\TypesLib.sol

library TypesLib {
    struct SellMode {
        uint price;
        uint times;
        uint dateLimit;
    }
}

// File: contracts\models\Data.sol

// Data - for storing data
contract Data {
    uint id;                 // id
    string dataName;         // data name
    string dataSource;       // data_source address
    uint sellModeCounter;     
    mapping(uint => TypesLib.SellMode) sellModes;
    uint8 status;            // status
    string schemaJson;       // data_source api description information
    uint createDateTime;     // create time, timestamp
    address issuer;          // data creator (hex of common.Address)

    // 限定指定人修改数据
    modifier checkOwner() {
        require(msg.sender == issuer);
        _;
    }

    function Data(uint _id, address _issuer)
        public
    {
        id = _id;
        issuer = _issuer;
        status = 1;
        createDateTime = now;
        sellModeCounter = 0;
    }

    function getId() public view returns (uint) {
        return id;
    }

    function getDataName() public view  returns (string) {
        return dataName;
    }
    
    function getDataSource() public view returns (string) {
        return dataSource;
    }

    function getSellModeById(uint _sellModeId) 
        public view returns (uint, uint, uint)
    {
        return (
            sellModes[_sellModeId].price,
            sellModes[_sellModeId].times,
            sellModes[_sellModeId].dateLimit
        );
    }

    function getStatus() public view returns (uint8) {
        return status;
    }

    function getSchemaJson() public view returns (string) {
        return schemaJson;
    }

    function getCreateDateTime() public view returns (uint) {
        return createDateTime;
    }

    function getIssuer() public view returns (address) {
        return issuer;
    }

    function getPrice(uint _id) public view returns (uint) {
        TypesLib.SellMode memory sellMode = sellModes[_id];
        return sellMode.price;
    }

    function getTimes(uint _id) public view returns (uint) {
        TypesLib.SellMode memory sellMode = sellModes[_id];
        return sellMode.times;
    }

    function getDateLimit(uint _id) public view returns (uint) {
        TypesLib.SellMode memory sellMode = sellModes[_id];
        return sellMode.dateLimit;
    }

    function load()
        public view
        returns (uint, string, string, uint, uint8, string, uint, address)
    {
        return (
            id, 
            dataName, 
            dataSource, 
            sellModeCounter, 
            status, 
            schemaJson, 
            createDateTime, 
            issuer
        );
    }

    function setStatus(uint8 _status) public checkOwner {
        status = _status;
    }

    function setSellModeById(uint _price, uint _times, uint _dateLimit,uint _sellModeId) public {
        sellModes[_sellModeId] = TypesLib.SellMode({price: _price, times: _times, dateLimit: _dateLimit});
    }
    
    function save(
        string _dataName, string _dataSource, string _schemaJson, uint[] _prices, uint[] _times, uint[] _dateLimits
    ) public checkOwner
    {
        dataName = _dataName;
        dataSource = _dataSource;
        schemaJson = _schemaJson;
        for (uint i = 0; i < _prices.length; i++) {
            sellModeCounter = sellModeCounter + 1;
            sellModes[sellModeCounter] = TypesLib.SellMode({price: _prices[i], times: _times[i], dateLimit: _dateLimits[i]});
        }
    }

}

// File: contracts\service\DataManager.sol

// DataManager - for managing all datas
contract DataManager {

    // contract owner, have super authority
    address Owner;
    // id counter
    uint idCounter;
    address[] dataAddrs;
    mapping(uint => address) idIndex;
    mapping(address => address[]) issuerIndex;


    event DataCreated(address issuer, uint dataId, address contractAddr);

    // constructor
    function DataManager() public
    {
        Owner = msg.sender;
        idCounter = 0;
    }

    // anyone can create a data without permission restrictions
    // createData - create a new data, store in this contract
    function createData()
        public
    {
        idCounter = idCounter + 1;

        Data d = new Data(idCounter, msg.sender);
        address dAddr = address(d);

        dataAddrs.push(dAddr);
        idIndex[idCounter] = dAddr;
        issuerIndex[msg.sender].push(dAddr);

        emit DataCreated(msg.sender, idCounter, dAddr);
    }

    function getData(uint id)
        public view
        returns (address addr)
    {
        address d = idIndex[id];
        return d;
    }

    function getDataCounter()
        public view
        returns (uint)
    {
        return idCounter;
    }

    function getAllDataAddrs()
        public view
        returns (address[])
    {
        return dataAddrs;
    }

    function getIssuerDataAddrs(address issuer)
        public view
        returns (address[])
    {
        return issuerIndex[issuer];
    }

}
