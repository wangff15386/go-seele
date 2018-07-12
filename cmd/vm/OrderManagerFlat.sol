pragma solidity ^0.4.18;

// File: contracts\libraries\StatusLib.sol

library StatusLib {

    // uint8
    enum OrderStatus {
        Initial,    // 0
        Signed,  // 1
        Payed       // 2
    }
    enum SubOrderExecStatus {
        Initial,
        Executing,
        Uploaded,
        DataPrepared,
        Finish
    }
    enum MasterOrderExecStatus {
        Initial,
        Executing,
        DataReady,
        DataPrepared,
        Finish
    }
}

// File: contracts\libraries\AlgorithmOrderLib.sol

library AlgorithmOrderLib {

    struct AlgorithmOrder {
        address purchaser;
        address supplier;
        address algorithm;
        uint times;
        uint fee;
        uint dateLimit;
        StatusLib.SubOrderExecStatus execStatus;
        string paramJson;
        address dataHash;
    }
    

    function create(address _purchaser, address _supplier, address _algorithm, uint _fee, uint _times, uint _dateLimit)
        internal pure returns (AlgorithmOrder)
    {
        address _dataHash;
        return AlgorithmOrder({
            purchaser: _purchaser,
            supplier: _supplier,
            algorithm: _algorithm,
            fee: _fee,
            times: _times,
            dateLimit: _dateLimit,
            execStatus: StatusLib.SubOrderExecStatus.Initial,
            paramJson: "",
            dataHash: _dataHash
        });
    }

    function load(AlgorithmOrder storage _this)
        internal view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        return (
            _this.purchaser, _this.supplier, _this.algorithm, _this.fee, _this.times, _this.execStatus, _this.paramJson, _this.dataHash
        );
    }

    function execute(AlgorithmOrder storage _this, string _paramJson)
        internal
        returns (bool)
    {
        _this.paramJson = _paramJson;
        _this.execStatus = StatusLib.SubOrderExecStatus.Executing;
        return true;
    }

    function upload(AlgorithmOrder storage _this, address _dataHash)
        internal
        returns (bool)
    {
        _this.dataHash = _dataHash;
        _this.execStatus = StatusLib.SubOrderExecStatus.Uploaded;
	return true;
    }

    function download(AlgorithmOrder storage _this)
        public view
        returns (address)
    {
        return _this.dataHash;
    }

    function finish(AlgorithmOrder storage _this)
        internal
        returns (bool)
    {
        _this.execStatus = StatusLib.SubOrderExecStatus.Finish;
        return true;
    }

    function getStatus(AlgorithmOrder storage _this)
        internal view
        returns (StatusLib.SubOrderExecStatus)
    {
        return _this.execStatus;
    }

    function setStatus(AlgorithmOrder storage _this, StatusLib.SubOrderExecStatus _status) 
        internal
    {
        _this.execStatus = _status;
    }

}

// File: contracts\libraries\ComputeOrderLib.sol

library ComputeOrderLib {

    struct ComputeOrder {
        address purchaser;
        address supplier;
        address compute;
        uint times;
        uint fee;
        uint dateLimit;
        StatusLib.SubOrderExecStatus execStatus;
        string paramJson;
        address dataHash;
    }
    

    function create(address _purchaser, address _supplier, address _compute, uint _fee, uint _times, uint _dateLimit)
        internal pure returns (ComputeOrder)
    {
        address _dataHash;
        return ComputeOrder({
            purchaser: _purchaser,
            supplier: _supplier,
            compute: _compute,
            fee: _fee,
            times: _times,
            dateLimit: _dateLimit,
            execStatus: StatusLib.SubOrderExecStatus.Initial,
            paramJson: "",
            dataHash: _dataHash
        });
    }

    function load(ComputeOrder storage _this)
        internal view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        return (
            _this.purchaser, _this.supplier, _this.compute, _this.fee, _this.times, _this.execStatus, _this.paramJson, _this.dataHash
        );
    }

    function execute(ComputeOrder storage _this, string _paramJson)
        internal
        returns (bool)
    {
        _this.paramJson = _paramJson;
        _this.execStatus = StatusLib.SubOrderExecStatus.Executing;
        return true;
    }

    function dataPrepared(ComputeOrder storage _this)
        internal
        returns (bool)
    {
        _this.execStatus = StatusLib.SubOrderExecStatus.DataPrepared;
        return true;
    }

    function upload(ComputeOrder storage _this, address _dataHash)
        internal
        returns (bool)
    {
        _this.dataHash = _dataHash;
        _this.execStatus = StatusLib.SubOrderExecStatus.Uploaded;
        return true;
    }

    function download(ComputeOrder storage _this)
        public view
        returns (address)
    {
        return _this.dataHash;
    }

    function finish(ComputeOrder storage _this)
        internal
        returns (bool)
    {
        _this.execStatus = StatusLib.SubOrderExecStatus.Finish;
        return true;
    }

    function getStatus(ComputeOrder storage _this)
        internal view
        returns (StatusLib.SubOrderExecStatus)
    {
        return _this.execStatus;
    }

    function setStatus(ComputeOrder storage _this, StatusLib.SubOrderExecStatus _status) 
        internal
    {
        _this.execStatus = _status;
    }

}

// File: contracts\libraries\DataOrderLib.sol

library DataOrderLib {
    
    struct DataOrder {
        address purchaser;
        address supplier;
        address data;
        uint fee;
        uint times;
        uint dateLimit;
        StatusLib.SubOrderExecStatus execStatus;
        string paramJson;
        address dataHash;
    }
    
    function create(address _purchaser, address _supplier, address _data, uint _fee, uint _times, uint _dateLimit)
        internal pure returns (DataOrder)
    {
        address _dataHash;
        return DataOrder(
            {
                purchaser: _purchaser,
                supplier: _supplier,
                data: _data,
                fee: _fee,
                times: _times,
                dateLimit: _dateLimit,
                execStatus: StatusLib.SubOrderExecStatus.Initial,
                paramJson: "",
                dataHash: _dataHash
            }
        );
    }

    function load(DataOrder storage _this)
        internal view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        return (
            _this.purchaser, _this.supplier, _this.data, _this.fee, _this.times, _this.execStatus, _this.paramJson, _this.dataHash
        );
    }

    function execute(DataOrder storage _this, string _paramJson)
        internal
        returns (bool)
    {
        _this.paramJson = _paramJson;
        _this.execStatus = StatusLib.SubOrderExecStatus.Executing;
        return true;

        //emit StatusModified(_this.purchaser, _this.supplier, _this.status, _this.execStatus, _this.paramJson, _this.dataHash);
    }

    function upload(DataOrder storage _this, address _dataHash)
        internal
        returns (bool)
    {
        _this.dataHash = _dataHash;
        _this.execStatus = StatusLib.SubOrderExecStatus.Uploaded;
        return true;

        //_this.supplier.transfer(_this.fee);

        //emit StatusModified(_this.purchaser, _this.supplier, _this.status, _this.execStatus, _this.paramJson, _this.dataHash);
    }

    function download(DataOrder storage _this)
        public view
        returns (address)
    {
        return _this.dataHash;
    }

    function finish(DataOrder storage _this)
        internal
        returns (bool)
    {
        _this.execStatus = StatusLib.SubOrderExecStatus.Finish;
        return true;
        //emit StatusModified(_this.purchaser, _this.supplier, _this.status, _this.execStatus, _this.paramJson, _this.dataHash);
    }

    function getStatus(DataOrder storage _this)
        internal view
        returns (StatusLib.SubOrderExecStatus)
    {
        return _this.execStatus;
    }

    function setStatus(DataOrder storage _this, StatusLib.SubOrderExecStatus _status) 
        internal
    {
        _this.execStatus = _status;
    }

}

// File: contracts\libraries\UtilLib.sol

library UtilLib {

    function addressLength(address[] _addrs)
        internal pure
        returns (uint)
    {
        return _addrs.length;
    }
}

// File: contracts\libraries\TypesLib.sol

library TypesLib {
    struct SellMode {
        uint price;
        uint times;
        uint dateLimit;
    }
}

// File: contracts\models\Algorithm.sol

// Algorithm for storing algorithm data
contract Algorithm {
    uint id;
    string algorithmName;
    string algorithmSource;
    string algorithmUrl;
    uint sellModeCounter;
    mapping(uint => TypesLib.SellMode) sellModes;
    uint8 status;
    string schemaJson;
    uint createDateTime;
    address issuer;

    modifier checkOwner() {
        require(msg.sender == issuer);
        _;
    }

    function Algorithm(uint _id, address _issuer)
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

    function getAlgorithmName() public view returns (string) {
        return algorithmName;
    }

    function getAlgorithmSource() public view returns (string) {
        return algorithmSource;
    }

    function getAlgorithmUrl() public view returns (string) {
        return algorithmUrl;
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

    function setStatus(uint8 _status) public checkOwner {
        status = _status;
    }

    function setSellModeById(uint _price, uint _times, uint _dateLimit, uint _sellModeId) public {
        sellModes[_sellModeId] = TypesLib.SellMode({price: _price, times: _times, dateLimit: _dateLimit});
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

    function save(
        string _algorithmName,
        string _algorithmSource,
        string _algorithmUrl,
        string _schemaJson,
        uint[] _prices, uint[] _times, uint[] _dateLimits
    ) public checkOwner 
    {
        algorithmName = _algorithmName;
        algorithmSource = _algorithmSource;
        algorithmUrl = _algorithmUrl;
        schemaJson = _schemaJson;
        for (uint i = 0; i < _prices.length; i++) {
            sellModeCounter = sellModeCounter + 1;
            sellModes[sellModeCounter] = TypesLib.SellMode({price: _prices[i], times: _times[i], dateLimit: _dateLimits[i]});
        }
    }

    function load() 
        public view 
        returns (uint, string, string, string, uint, uint8, string, uint, address) 
    {
        return (
            id, 
            algorithmName, 
            algorithmSource, 
            algorithmUrl, 
            sellModeCounter, 
            status, 
            schemaJson, 
            createDateTime, 
            issuer
        );
    }
}

// File: contracts\models\Compute.sol

contract Compute {
    uint id;                 // id
    string computeName;      // compute name  
    uint sellModeCounter;    
    mapping(uint => TypesLib.SellMode) sellModes;    // sell modes
    uint8 status;            // status
    string schemaJson;       // compute description information
    uint createDateTime;     // create time, timestamp
    address issuer;          // compute creator (hex of common.Address)

    // 限定指定人修改数据
    modifier checkOwner() {
        require(msg.sender == issuer);
        _;
    }

    function Compute(uint _id, address _issuer)
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

    function getComputeName() public view  returns (string) {
        return computeName;
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

    function load()
        public view
        returns (uint, string, uint, uint8, string, uint, address)
    {
        return (
            id, computeName, sellModeCounter, status, schemaJson, createDateTime, issuer
        );
    }

    function setStatus(uint8 _status) public checkOwner {
        status = _status;
    }
    
    function setSellModeById(uint _price, uint _times, uint _dateLimit, uint _sellModeId) public {
        sellModes[_sellModeId] = TypesLib.SellMode({price: _price, times: _times, dateLimit: _dateLimit});
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
    
    function save(
        string _computeName, string _schemaJson, uint[] _prices, uint[] _times, uint[] _dateLimits
    ) public checkOwner
    {
        computeName = _computeName;
        schemaJson = _schemaJson;
        for (uint i = 0; i < _prices.length; i++) {
            sellModeCounter = sellModeCounter + 1;
            sellModes[sellModeCounter] = TypesLib.SellMode({price: _prices[i], times: _times[i], dateLimit: _dateLimits[i]});
        }
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

// File: contracts\models\MasterOrder.sol

// Order - for managing data orders and other orders
contract MasterOrder {

    using StatusLib for *;
    using DataOrderLib for *;
    using AlgorithmOrderLib for *;
    using ComputeOrderLib for *;

    enum ProductType {
        Data,
        Algorithm,
        Compute,
        Master
    }
    
    string orderName;
    uint id;
    address purchaser;
    address[] suppliers;
    // orderStatus: Initial，Signed，Payed
    StatusLib.OrderStatus status;
    // dataAddr -> DataOrder
    address[] datas;
    mapping(address => DataOrderLib.DataOrder) dataOrders;
    //  algoAddr -> AlgorithmOrder
    address[] algorithms;
    mapping(address => AlgorithmOrderLib.AlgorithmOrder) algorithmOrders;
    // // compAddr -> ComputeOrder
    address[] computes;
    mapping(address => ComputeOrderLib.ComputeOrder) computeOrders;
    // order balance
    uint balance;
    uint freezeAmount;
    uint execTimes;
    uint createTime;
    uint payTime;
    uint firstExecTime;
    uint endTime;
    uint minExecTimes;
    uint totalFeeOnce;
    // sign list
    uint signNum;
    mapping(address => uint8) signers;
    StatusLib.MasterOrderExecStatus masterOrderStatus;

    event OrderStatus(address purchaser, address[] suppliers, StatusLib.OrderStatus status);
    event ExecStatus(address purchaser, address supplier, address product, ProductType productType, StatusLib.MasterOrderExecStatus execStatus, string paramJson);

    // check msg.sender whether it's a purchaser
    modifier checkPurchaser() {
        require(msg.sender == purchaser);
        _;
    }

    // check msg.sender whether it's a supplier
    modifier checkSupplier() {
        bool isSupplier = false;
        uint len = UtilLib.addressLength(suppliers);
        for(uint i = 0; i < len; i++) {
            if(msg.sender == suppliers[i]) {
                isSupplier = true;
                break;
            }
        }
        require(isSupplier == true);
        _;
    }

    // check order excuteable
    modifier checkExecutable()
    {
        bool orderExecutable = true;
        orderExecutable =  checkExecutableFunc();
        
        require(orderExecutable == true);
        _;
    }

    function MasterOrder(uint _id, string _orderName, address _purchaser, address[] _datas, address[] _algorithms, address[] _computes, uint _balance)
        public
    {
        id = _id;
        purchaser = _purchaser;
        balance = _balance;
        execTimes = 0;
        orderName = _orderName;
        freezeAmount = 0;
        createTime = now;

        addDatas(_datas);
        if(_algorithms.length > 0) {
            addAlgorithms(_algorithms);
        }
        if(_computes.length > 0) {
            addComputes(_computes);
        }

        uint i;
        address addr;
        for (i = 0; i < UtilLib.addressLength(datas); i++) {
            addr = datas[i];
            DataOrderLib.DataOrder storage dataOrder = dataOrders[addr];
            totalFeeOnce = totalFeeOnce + dataOrder.fee;
            if (i == 0) {
                minExecTimes = dataOrder.times;
                endTime = dataOrder.dateLimit;
            } else {
                if (dataOrder.times < minExecTimes) {
                    minExecTimes = dataOrder.times;
                }
                if (dataOrder.dateLimit < endTime) {
                    endTime = dataOrder.dateLimit;
                }
            }
        }
        for (i = 0; i < UtilLib.addressLength(algorithms); i++) {
            addr = algorithms[i];
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[addr];
            totalFeeOnce = totalFeeOnce + algOrder.fee;
            if (algOrder.times < minExecTimes) {
                minExecTimes = algOrder.times;
            }
            if (algOrder.dateLimit < endTime) {
                endTime = algOrder.dateLimit;
            }
        }
        for (i = 0; i < UtilLib.addressLength(computes); i++) {
            addr = computes[i];
            ComputeOrderLib.ComputeOrder storage cptOrder = computeOrders[addr];
            totalFeeOnce = totalFeeOnce + cptOrder.fee;
            if (cptOrder.times < minExecTimes) {
                minExecTimes = cptOrder.times;
            }
            if (cptOrder.dateLimit < endTime) {
                endTime = cptOrder.dateLimit;
            }
        }

        // active event
        emit OrderStatus(purchaser, suppliers, StatusLib.OrderStatus.Initial);
    }

    function load()
        public view
        returns (uint, string, address, address[], address[], address[], address[], uint, uint)
    {
        return (
            id, orderName, purchaser, suppliers, datas, algorithms, computes, balance, freezeAmount
        );
    }

    function load2()
        public view
        returns (StatusLib.OrderStatus, StatusLib.MasterOrderExecStatus, uint, uint, uint, uint, uint, uint, uint)
    {
        return (
            status, masterOrderStatus, execTimes, createTime, payTime, firstExecTime, endTime, minExecTimes, totalFeeOnce
        );
    }

    function getBalance()
        public view
        returns (uint)
    {
        return balance;
    }

    function getMasterStatus()
        public view
        returns (StatusLib.OrderStatus)
    {
        return status;
    }

    function getMasterOrderExecStatus() 
        public view
        returns (StatusLib.MasterOrderExecStatus)
    {
        return masterOrderStatus;
    }

    function getExecTimes() 
        public view
        returns (uint)
    {
        return execTimes;
    }

    function resetMastOrderExecStatus()
        public
    {
        masterOrderStatus = StatusLib.MasterOrderExecStatus.Initial;
        uint len;
        uint i;

        len = UtilLib.addressLength(datas);
        for (i = 0; i < len; i++) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[datas[i]];
            dataOrder.setStatus(StatusLib.SubOrderExecStatus.Initial);
        }
        len = UtilLib.addressLength(algorithms);
        for (i = 0; i < len; i++) {
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[algorithms[i]];
            algOrder.setStatus(StatusLib.SubOrderExecStatus.Initial);
        }
        len = UtilLib.addressLength(computes);
        for (i = 0; i < len; i++) {
            ComputeOrderLib.ComputeOrder storage cptOrder = computeOrders[computes[i]];
            cptOrder.setStatus(StatusLib.SubOrderExecStatus.Initial);
        }
    }

    function getSupplierCount()
        public view
        returns (uint)
    {
        return suppliers.length;
    }

    function getSupplier(uint idx)
        public view
        returns (address)
    {
        return suppliers[idx];
    }

    function getDataOrder(address data)
        public view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        DataOrderLib.DataOrder storage order = dataOrders[data];
        return (
            order.purchaser, order.supplier, order.data, order.fee, order.times, order.execStatus, order.paramJson, order.dataHash
        );
    }

    function getAlgorithmOrder(address algo)
        public view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        AlgorithmOrderLib.AlgorithmOrder storage order = algorithmOrders[algo];
        return (
            order.purchaser, order.supplier, order.algorithm, order.fee, order.times, order.execStatus, order.paramJson, order.dataHash
        );
    }

    function getComputeOrder(address compute)
        public view
        returns (address, address, address, uint, uint, StatusLib.SubOrderExecStatus, string, address)
    {
        ComputeOrderLib.ComputeOrder storage order = computeOrders[compute];
        return (
            order.purchaser, order.supplier, order.compute, order.fee, order.times, order.execStatus, order.paramJson, order.dataHash
        );
    }

    function getSigner(address signer)
        public view
        returns (uint8)
    {
        return signers[signer];
    }

    function getSignNum()
        public view
        returns (uint)
    {
        return signNum;
    }

    function addDatas(address[] _datas)
        public
        returns (bool)
    {
        for(uint i = 0; i < _datas.length; i++) {
            // create data orders
            address dataAddr = _datas[i];
            Data dt = Data(dataAddr);
            DataOrderLib.DataOrder memory order = DataOrderLib.create(
                purchaser, dt.getIssuer(), dataAddr, dt.getPrice(1), dt.getTimes(1), dt.getDateLimit(1)
            );
            if(signers[dt.getIssuer()] == 0){
                suppliers.push(dt.getIssuer());
                signers[dt.getIssuer()] = 1;
            }
            datas.push(dataAddr);
            dataOrders[dataAddr] = order;
        }
        return true;
    }

    function addAlgorithms(address[] _algorithms)
        public
        returns (bool)
    {
        // create algorithm orders
        for(uint j = 0; j < _algorithms.length; j++) {
            address algoAddr = _algorithms[j];
            Algorithm algo = Algorithm(algoAddr);
            AlgorithmOrderLib.AlgorithmOrder memory order = AlgorithmOrderLib.create(
                purchaser, algo.getIssuer(), algoAddr, algo.getPrice(1), algo.getTimes(1), algo.getDateLimit(1)
            );
            if(signers[algo.getIssuer()] == 0){
                suppliers.push(algo.getIssuer());
                signers[algo.getIssuer()] = 1;
            }
            algorithms.push(algoAddr);
            algorithmOrders[algoAddr] = order;
        }
        
        return true;
    }

    function addComputes(address[] _computes)
        public
        returns (bool)
    {
        // create compute orders
        for(uint k = 0; k < _computes.length; k++) {
            address compAddr = _computes[k];
            Compute comp = Compute(compAddr);
            ComputeOrderLib.ComputeOrder memory order = ComputeOrderLib.create(
                purchaser, comp.getIssuer(), compAddr, comp.getPrice(1), comp.getTimes(1), comp.getDateLimit(1)
            );
            if(signers[comp.getIssuer()] == 0){
                suppliers.push(comp.getIssuer());
                signers[comp.getIssuer()] = 1;
            }
            computes.push(compAddr);
            computeOrders[compAddr] = order;
        }
        
        return true;
    }

    function sign()
        public checkSupplier
    {
        require(status == StatusLib.OrderStatus.Initial);
        require(signers[msg.sender] != 2);
        signNum++;
        signers[msg.sender] = 2;
        if(signNum == UtilLib.addressLength(suppliers)){
            status = StatusLib.OrderStatus.Signed;
            emit OrderStatus(purchaser, suppliers, status);
        }
    }

    // pay - pay for masterOrder contract: datas, algorithms and computes.
    function pay()
        public payable checkPurchaser
    {
        require(status == StatusLib.OrderStatus.Signed && msg.value == balance);

        // todo: check product
        status = StatusLib.OrderStatus.Payed;
        freezeAmount = balance;
        payTime = now;
        emit OrderStatus(purchaser, suppliers, status);
    }

    function checkExecutableFunc()
        internal view
        returns (bool)
    {
        uint execTime = now;
        // check is can execute status
        if ((masterOrderStatus != StatusLib.MasterOrderExecStatus.Initial && 
            masterOrderStatus != StatusLib.MasterOrderExecStatus.Finish) || 
            status != StatusLib.OrderStatus.Payed) 
        {
            return false;
        }

        // check balance\times\dateLimit
        if ((execTimes + 1) > minExecTimes) {
            return false;
        }
        if (execTime > endTime) {
            return false;
        }
        if (totalFeeOnce > balance) {
            return false;
        }
        
        return true;
    }


    // execute order
    function execute(string _paramJson)
        public checkPurchaser checkExecutable
        returns (bool)
    {
        uint len;
        uint i;
        execTimes = execTimes + 1;
        if (execTimes == 1) {
            firstExecTime =  now;
        }
        masterOrderStatus = StatusLib.MasterOrderExecStatus.Executing;
        // execute data order
        len = UtilLib.addressLength(datas);
        for (i = 0; i < len; i++) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[datas[i]];
            dataOrder.execute(_paramJson);
            emit ExecStatus(dataOrder.purchaser, dataOrder.supplier, dataOrder.data, ProductType.Data, masterOrderStatus, dataOrder.paramJson);
        }

        // execute algorithm order
        len = UtilLib.addressLength(algorithms);
        for (i = 0; i < len; i++) {
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[algorithms[i]];
            algOrder.execute(_paramJson);

            emit ExecStatus(algOrder.purchaser, algOrder.supplier, algOrder.algorithm, ProductType.Algorithm, masterOrderStatus, algOrder.paramJson);
        }

         // execute compute order
        len = UtilLib.addressLength(computes);
        for (i = 0; i < len; i++) {
            ComputeOrderLib.ComputeOrder storage cptOrder = computeOrders[computes[i]];
            cptOrder.execute(_paramJson);
        }

        return true;
    }

    function checkAllDataAndAlgUploaded()
        internal view
        returns (bool)
    {
        uint i;
        for (i = 0; i < UtilLib.addressLength(datas); i++) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[datas[i]];
            if (dataOrder.getStatus() != StatusLib.SubOrderExecStatus.Uploaded) {
                return false;
            }
        }

        for (i = 0; i < UtilLib.addressLength(algorithms); i++) {
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[algorithms[i]];
            if (algOrder.getStatus() != StatusLib.SubOrderExecStatus.Uploaded) {
                return false;
            }
        }

        return true;
    }

    function checkAllCptUploaded()
        internal view
        returns (bool)
    {
        for (uint i = 0; i < UtilLib.addressLength(computes); i++) {
            ComputeOrderLib.ComputeOrder storage order = computeOrders[computes[i]];
            if (order.getStatus() != StatusLib.SubOrderExecStatus.Uploaded) {
                return false;
            }
        }

        return true;
    }

    function upload(address _product, ProductType _productType, address _dataHash)
        public checkSupplier
    {
        uint len = 0;
        address addr;
        uint i;
        if(_productType == ProductType.Data) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[_product];
            dataOrder.upload(_dataHash);
            //pay
            dataOrder.supplier.transfer(dataOrder.fee);
            balance = balance - dataOrder.fee;
        }

        if(_productType == ProductType.Algorithm) {
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[_product];
            algOrder.upload(_dataHash);
            //pay
            algOrder.supplier.transfer(algOrder.fee);
            balance = balance - algOrder.fee;
        }
        
        // check all data and algupload
        if(!checkAllDataAndAlgUploaded()) {
            return;
        }

        // if has no compute
        len = UtilLib.addressLength(computes);
        if (len == 0) {
            masterOrderStatus = StatusLib.MasterOrderExecStatus.DataReady;
            emit ExecStatus(purchaser, purchaser, purchaser, ProductType.Master, masterOrderStatus, "");
        } else {
            if (_productType == ProductType.Compute) {
                ComputeOrderLib.ComputeOrder storage cptOrder = computeOrders[_product];
                cptOrder.upload(_dataHash);
                //pay
                cptOrder.supplier.transfer(cptOrder.fee);
                balance = balance - cptOrder.fee;
                // check all compute uploaded
                if (checkAllCptUploaded()) {
                    masterOrderStatus = StatusLib.MasterOrderExecStatus.DataReady;
                    emit ExecStatus(purchaser, purchaser, purchaser, ProductType.Master, masterOrderStatus, "");
                }
            // notice computes data and alg ready
            } else {
                masterOrderStatus = StatusLib.MasterOrderExecStatus.DataPrepared;
                for (i = 0; i < len; i++) {
                    addr = computes[i];
                    cptOrder = computeOrders[addr];
                    cptOrder.dataPrepared();

                    emit ExecStatus(cptOrder.purchaser, cptOrder.supplier, cptOrder.compute, ProductType.Compute, masterOrderStatus, cptOrder.paramJson);
                }
            }
        }
    }

    // download order dataHash
    function download()
        public view
        returns (address[], address[], address[], uint)
    {
        uint i;
        uint len;
        len = UtilLib.addressLength(datas);
        address[] memory dtHashes = new address[](len);
        for(i = 0; i < len; i++) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[datas[i]];
            dtHashes[i] = dataOrder.dataHash;
        }

        len = UtilLib.addressLength(algorithms);
        address[] memory algoHashes = new address[](len);
        for(i = 0; i < len; i++) {
            AlgorithmOrderLib.AlgorithmOrder storage algoOrder = algorithmOrders[algorithms[i]];
            algoHashes[i] = algoOrder.dataHash;
        }

        len = UtilLib.addressLength(computes);
        address[] memory compHashes = new address[](len);
        for(i = 0; i < len; i++) {
            ComputeOrderLib.ComputeOrder storage compOrder = computeOrders[computes[i]];
            compHashes[i] = compOrder.dataHash;
        }
        
        return (dtHashes, algoHashes, compHashes, execTimes);
    }

    // finish order
    function finish()
        public checkPurchaser
    {
        for (uint i = 0; i < UtilLib.addressLength(datas); i++) {
            DataOrderLib.DataOrder storage dataOrder = dataOrders[datas[i]];
            dataOrder.finish();
        }
        for (i = 0; i < UtilLib.addressLength(algorithms); i++) {
            AlgorithmOrderLib.AlgorithmOrder storage algOrder = algorithmOrders[algorithms[i]];
            algOrder.finish();
        }
        for (i = 0; i < UtilLib.addressLength(computes); i++) {
            ComputeOrderLib.ComputeOrder storage cptOrder = computeOrders[computes[i]];
            cptOrder.finish();
        }
        masterOrderStatus = StatusLib.MasterOrderExecStatus.Finish;
    }

}

// File: contracts\service\OrderManager.sol

// OrderManager - for managing all orders
contract OrderManager {

    // contract owner, have super authority
    address Owner;
    // id counter
    uint idCounter;

    // store orders
    address[] orders;
    mapping(address => address[]) purchaserIndex;
    mapping(address => address[]) supplierIndex;
    mapping(address => address[]) productIndex;

    // 订单创建事件
    event OrderCreated(address purchaser, address[] suppliers, uint orderId, address contractAddr);

    function OrderManager() public
    {
        Owner = msg.sender;
        idCounter = 0;
    }

    // 创建数据交易
    function createOrder(string _orderName, address[] _datas, address[] _algorithms, address[] _computes, uint _balance)
        public
    {
        require(_datas.length > 0);

        uint i;
        idCounter = idCounter + 1;
        MasterOrder order = new MasterOrder(idCounter, _orderName, msg.sender, _datas, _algorithms, _computes, _balance);
        
        address oAddr = address(order);
        orders.push(oAddr);
        purchaserIndex[msg.sender].push(oAddr);
        address[] memory suppliers = new address[](order.getSupplierCount());
        for (i = 0; i < order.getSupplierCount(); i++) {
            address supplier = order.getSupplier(i);
            suppliers[i] = supplier;
            supplierIndex[supplier].push(oAddr);
        }

        for (i = 0; i < UtilLib.addressLength(_datas); i++) {
            productIndex[_datas[i]].push(oAddr);
        }
        for (i = 0; i < UtilLib.addressLength(_algorithms); i++) {
            productIndex[_algorithms[i]].push(oAddr);
        }
        for (i = 0; i < UtilLib.addressLength(_computes); i++) {
            productIndex[_computes[i]].push(oAddr);
        }

        // active event, listen by purchaser and supplier
        emit OrderCreated(msg.sender, suppliers, idCounter, oAddr);
    }

    function getIdCounter()
        public view
        returns (uint)
    {
        return idCounter;
    }

    function getAllOrder()
        public view
        returns (address[])
    {
        return orders;
    }

    function getPurchaserOrder(address purchaser)
        public view
        returns (address[])
    {
        return purchaserIndex[purchaser];
    }

    function getSupplierOrder(address supplier)
        public view
        returns (address[])
    {
        return supplierIndex[supplier];
    }

    function getProductOrder(address product)
        public view
        returns (address[])
    {
        return productIndex[product];
    }

}
