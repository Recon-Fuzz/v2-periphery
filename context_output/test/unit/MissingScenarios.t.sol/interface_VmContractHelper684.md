# Interface: VmContractHelper684

## Metadata

- **Name**: VmContractHelper684
- **Type**: Interface
- **Path**: test/unit/MissingScenarios.t.sol

## Public/External Functions

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 33146:72:657

**Signature:**
```solidity
function deployCode(string memory _artifact) external returns (address);;
```

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 33223:87:657

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 33315:92:657

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args) external returns (address);;
```

### deployCode(string,bytes,bytes32)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 33412:107:657

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, bytes32 _salt) external returns (address);;
```

### deployCode(string,uint256)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 33524:88:657

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value) external returns (address);;
```

### deployCode(string,uint256,bytes32)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 33617:103:657

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes,uint256)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 33725:108:657

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value) external returns (address);;
```

### deployCode(string,bytes,uint256,bytes32)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 33838:123:657

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value, bytes32 _salt) external returns (address);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 33966:74:657

**Signature:**
```solidity
function getCode(string memory _artifact) external returns (bytes memory);;
```
