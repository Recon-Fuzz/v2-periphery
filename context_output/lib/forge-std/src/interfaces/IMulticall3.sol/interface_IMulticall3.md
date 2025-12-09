# Interface: IMulticall3

## Metadata

- **Name**: IMulticall3
- **Type**: Interface
- **Path**: lib/forge-std/src/interfaces/IMulticall3.sol

## Structs

### Call

```solidity
struct Call {
    address target;
    bytes callData;
}
```

### Call3

```solidity
struct Call3 {
    address target;
    bool allowFailure;
    bytes callData;
}
```

### Call3Value

```solidity
struct Call3Value {
    address target;
    bool allowFailure;
    uint256 value;
    bytes callData;
}
```

### Result

```solidity
struct Result {
    bool success;
    bytes returnData;
}
```

## Public/External Functions

### aggregate(struct IMulticall3.Call[])

- **Signature**: `aggregate(struct IMulticall3.Call[])`
- **Visibility**: external
- **Source Range**: 506:140:31

**Signature:**
```solidity
function aggregate(Call[] calldata calls) external payable returns (uint256 blockNumber, bytes[] memory returnData);;
```

### aggregate3(struct IMulticall3.Call3[])

- **Signature**: `aggregate3(struct IMulticall3.Call3[])`
- **Visibility**: external
- **Source Range**: 652:98:31

**Signature:**
```solidity
function aggregate3(Call3[] calldata calls) external payable returns (Result[] memory returnData);;
```

### aggregate3Value(struct IMulticall3.Call3Value[])

- **Signature**: `aggregate3Value(struct IMulticall3.Call3Value[])`
- **Visibility**: external
- **Source Range**: 756:108:31

**Signature:**
```solidity
function aggregate3Value(Call3Value[] calldata calls) external payable returns (Result[] memory returnData);;
```

### blockAndAggregate(struct IMulticall3.Call[])

- **Signature**: `blockAndAggregate(struct IMulticall3.Call[])`
- **Visibility**: external
- **Source Range**: 870:168:31

**Signature:**
```solidity
function blockAndAggregate(Call[] calldata calls) external payable returns (uint256 blockNumber, bytes32 blockHash, Result[] memory returnData);;
```

### getBasefee()

- **Signature**: `getBasefee()`
- **Visibility**: external
- **Source Range**: 1044:62:31

**Signature:**
```solidity
function getBasefee() external view returns (uint256 basefee);;
```

### getBlockHash(uint256)

- **Signature**: `getBlockHash(uint256)`
- **Visibility**: external
- **Source Range**: 1112:85:31

**Signature:**
```solidity
function getBlockHash(uint256 blockNumber) external view returns (bytes32 blockHash);;
```

### getBlockNumber()

- **Signature**: `getBlockNumber()`
- **Visibility**: external
- **Source Range**: 1203:70:31

**Signature:**
```solidity
function getBlockNumber() external view returns (uint256 blockNumber);;
```

### getChainId()

- **Signature**: `getChainId()`
- **Visibility**: external
- **Source Range**: 1279:62:31

**Signature:**
```solidity
function getChainId() external view returns (uint256 chainid);;
```

### getCurrentBlockCoinbase()

- **Signature**: `getCurrentBlockCoinbase()`
- **Visibility**: external
- **Source Range**: 1347:76:31

**Signature:**
```solidity
function getCurrentBlockCoinbase() external view returns (address coinbase);;
```

### getCurrentBlockDifficulty()

- **Signature**: `getCurrentBlockDifficulty()`
- **Visibility**: external
- **Source Range**: 1429:80:31

**Signature:**
```solidity
function getCurrentBlockDifficulty() external view returns (uint256 difficulty);;
```

### getCurrentBlockGasLimit()

- **Signature**: `getCurrentBlockGasLimit()`
- **Visibility**: external
- **Source Range**: 1515:76:31

**Signature:**
```solidity
function getCurrentBlockGasLimit() external view returns (uint256 gaslimit);;
```

### getCurrentBlockTimestamp()

- **Signature**: `getCurrentBlockTimestamp()`
- **Visibility**: external
- **Source Range**: 1597:78:31

**Signature:**
```solidity
function getCurrentBlockTimestamp() external view returns (uint256 timestamp);;
```

### getEthBalance(address)

- **Signature**: `getEthBalance(address)`
- **Visibility**: external
- **Source Range**: 1681:77:31

**Signature:**
```solidity
function getEthBalance(address addr) external view returns (uint256 balance);;
```

### getLastBlockHash()

- **Signature**: `getLastBlockHash()`
- **Visibility**: external
- **Source Range**: 1764:70:31

**Signature:**
```solidity
function getLastBlockHash() external view returns (bytes32 blockHash);;
```

### tryAggregate(bool,struct IMulticall3.Call[])

- **Signature**: `tryAggregate(bool,struct IMulticall3.Call[])`
- **Visibility**: external
- **Source Range**: 1840:144:31

**Signature:**
```solidity
function tryAggregate(bool requireSuccess, Call[] calldata calls) external payable returns (Result[] memory returnData);;
```

### tryBlockAndAggregate(bool,struct IMulticall3.Call[])

- **Signature**: `tryBlockAndAggregate(bool,struct IMulticall3.Call[])`
- **Visibility**: external
- **Source Range**: 1990:192:31

**Signature:**
```solidity
function tryBlockAndAggregate(bool requireSuccess, Call[] calldata calls) external payable returns (uint256 blockNumber, bytes32 blockHash, Result[] memory returnData);;
```
