# Interface: VmContractHelper590

## Metadata

- **Name**: VmContractHelper590
- **Type**: Interface
- **Path**: test/integration/SuperVault/SuperVault.t.sol

## Public/External Functions

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 509492:72:580

**Signature:**
```solidity
function deployCode(string memory _artifact) external returns (address);;
```

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 509569:87:580

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 509661:92:580

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args) external returns (address);;
```

### deployCode(string,bytes,bytes32)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 509758:107:580

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, bytes32 _salt) external returns (address);;
```

### deployCode(string,uint256)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 509870:88:580

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value) external returns (address);;
```

### deployCode(string,uint256,bytes32)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 509963:103:580

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes,uint256)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 510071:108:580

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value) external returns (address);;
```

### deployCode(string,bytes,uint256,bytes32)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 510184:123:580

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value, bytes32 _salt) external returns (address);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 510312:74:580

**Signature:**
```solidity
function getCode(string memory _artifact) external returns (bytes memory);;
```
