# Interface: VmContractHelper703

## Metadata

- **Name**: VmContractHelper703
- **Type**: Interface
- **Path**: test/unit/SuperVaultAggregator.t.sol

## Public/External Functions

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 243938:72:661

**Signature:**
```solidity
function deployCode(string memory _artifact) external returns (address);;
```

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 244015:87:661

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 244107:92:661

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args) external returns (address);;
```

### deployCode(string,bytes,bytes32)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 244204:107:661

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, bytes32 _salt) external returns (address);;
```

### deployCode(string,uint256)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 244316:88:661

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value) external returns (address);;
```

### deployCode(string,uint256,bytes32)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 244409:103:661

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes,uint256)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 244517:108:661

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value) external returns (address);;
```

### deployCode(string,bytes,uint256,bytes32)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 244630:123:661

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value, bytes32 _salt) external returns (address);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 244758:74:661

**Signature:**
```solidity
function getCode(string memory _artifact) external returns (bytes memory);;
```
