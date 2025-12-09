# Interface: VmContractHelper621

## Metadata

- **Name**: VmContractHelper621
- **Type**: Interface
- **Path**: test/oracles/FixedPriceOracle.t.sol

## Public/External Functions

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 10105:72:623

**Signature:**
```solidity
function deployCode(string memory _artifact) external returns (address);;
```

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 10182:87:623

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 10274:92:623

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args) external returns (address);;
```

### deployCode(string,bytes,bytes32)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 10371:107:623

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, bytes32 _salt) external returns (address);;
```

### deployCode(string,uint256)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 10483:88:623

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value) external returns (address);;
```

### deployCode(string,uint256,bytes32)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 10576:103:623

**Signature:**
```solidity
function deployCode(string memory _artifact, uint256 _value, bytes32 _salt) external returns (address);;
```

### deployCode(string,bytes,uint256)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 10684:108:623

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value) external returns (address);;
```

### deployCode(string,bytes,uint256,bytes32)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 10797:123:623

**Signature:**
```solidity
function deployCode(string memory _artifact, bytes memory _args, uint256 _value, bytes32 _salt) external returns (address);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 10925:74:623

**Signature:**
```solidity
function getCode(string memory _artifact) external returns (bytes memory);;
```
