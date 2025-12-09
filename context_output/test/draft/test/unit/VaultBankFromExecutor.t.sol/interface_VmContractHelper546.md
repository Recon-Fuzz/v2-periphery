# Interface: VmContractHelper546

## Metadata

- **Name**: VmContractHelper546
- **Type**: Interface
- **Path**: test/draft/test/unit/VaultBankFromExecutor.t.sol

## Public/External Functions

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 11682:72:571

**Signature:**
```solidity
function deployCode(string memory _artifact) external returns (address);;
```

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 11759:87:571

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 11851:92:571

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args) external returns (address);;
```

### deployCode(string,bytes,bytes32)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 11948:107:571

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, bytes32 _salt) external returns (address);;
```

### deployCode(string,uint256)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 12060:88:571

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value) external returns (address);;
```

### deployCode(string,uint256,bytes32)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 12153:103:571

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes,uint256)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 12261:108:571

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value) external returns (address);;
```

### deployCode(string,bytes,uint256,bytes32)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 12374:123:571

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value, bytes32 _salt) external returns (address);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 12502:74:571

**Signature:**
```solidity
function getCode(string memory _artifact) external returns (bytes memory);;
```
