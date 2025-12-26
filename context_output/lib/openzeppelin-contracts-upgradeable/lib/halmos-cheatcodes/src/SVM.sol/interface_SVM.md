# Interface: SVM

## Metadata

- **Name**: SVM
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/halmos-cheatcodes/src/SVM.sol
- **Documentation**: @notice Symbolic Virtual Machine

## Public/External Functions

### createUint(uint256,string)

- **Signature**: `createUint(uint256,string)`
- **Visibility**: external
- **Source Range**: 212:95:38

**Signature:**
```solidity
function createUint(uint256 bitSize, string memory name) external pure returns (uint256 value);;
```

### createUint256(string)

- **Signature**: `createUint256(string)`
- **Visibility**: external
- **Source Range**: 356:81:38

**Signature:**
```solidity
function createUint256(string memory name) external pure returns (uint256 value);;
```

### createInt(uint256,string)

- **Signature**: `createInt(uint256,string)`
- **Visibility**: external
- **Source Range**: 489:93:38

**Signature:**
```solidity
function createInt(uint256 bitSize, string memory name) external pure returns (int256 value);;
```

### createInt256(string)

- **Signature**: `createInt256(string)`
- **Visibility**: external
- **Source Range**: 630:79:38

**Signature:**
```solidity
function createInt256(string memory name) external pure returns (int256 value);;
```

### createBytes(uint256,string)

- **Signature**: `createBytes(uint256,string)`
- **Visibility**: external
- **Source Range**: 780:102:38

**Signature:**
```solidity
function createBytes(uint256 byteSize, string memory name) external pure returns (bytes memory value);;
```

### createString(uint256,string)

- **Signature**: `createString(uint256,string)`
- **Visibility**: external
- **Source Range**: 976:104:38

**Signature:**
```solidity
function createString(uint256 byteSize, string memory name) external pure returns (string memory value);;
```

### createBytes32(string)

- **Signature**: `createBytes32(string)`
- **Visibility**: external
- **Source Range**: 1129:81:38

**Signature:**
```solidity
function createBytes32(string memory name) external pure returns (bytes32 value);;
```

### createBytes4(string)

- **Signature**: `createBytes4(string)`
- **Visibility**: external
- **Source Range**: 1258:79:38

**Signature:**
```solidity
function createBytes4(string memory name) external pure returns (bytes4 value);;
```

### createAddress(string)

- **Signature**: `createAddress(string)`
- **Visibility**: external
- **Source Range**: 1386:81:38

**Signature:**
```solidity
function createAddress(string memory name) external pure returns (address value);;
```

### createBool(string)

- **Signature**: `createBool(string)`
- **Visibility**: external
- **Source Range**: 1516:75:38

**Signature:**
```solidity
function createBool(string memory name) external pure returns (bool value);;
```

### createCalldata(string)

- **Signature**: `createCalldata(string)`
- **Visibility**: external
- **Source Range**: 1966:105:38

**Signature:**
```solidity
function createCalldata(string memory contractOrInterfaceName) external pure returns (bytes memory data);;
```

### createCalldata(string,bool)

- **Signature**: `createCalldata(string,bool)`
- **Visibility**: external
- **Source Range**: 2076:139:38

**Signature:**
```solidity
function createCalldata(string memory contractOrInterfaceName, bool includeViewAndPureFunctions) external pure returns (bytes memory data);;
```

### createCalldata(string,string)

- **Signature**: `createCalldata(string,string)`
- **Visibility**: external
- **Source Range**: 2220:129:38

**Signature:**
```solidity
function createCalldata(string memory filename, string memory contractOrInterfaceName) external pure returns (bytes memory data);;
```

### createCalldata(string,string,bool)

- **Signature**: `createCalldata(string,string,bool)`
- **Visibility**: external
- **Source Range**: 2354:163:38

**Signature:**
```solidity
function createCalldata(string memory filename, string memory contractOrInterfaceName, bool includeViewAndPureFunctions) external pure returns (bytes memory data);;
```

### enableSymbolicStorage(address)

- **Signature**: `enableSymbolicStorage(address)`
- **Visibility**: external
- **Source Range**: 2584:49:38

**Signature:**
```solidity
function enableSymbolicStorage(address) external;;
```

### snapshotStorage(address)

- **Signature**: `snapshotStorage(address)`
- **Visibility**: external
- **Source Range**: 2721:64:38

**Signature:**
```solidity
function snapshotStorage(address) external returns (uint256 id);;
```
