# Interface: IHevm

## Metadata

- **Name**: IHevm
- **Type**: Interface
- **Path**: lib/setup-helpers/lib/chimera/src/Hevm.sol

## Public/External Functions

### warp(uint256)

- **Signature**: `warp(uint256)`
- **Visibility**: external
- **Source Range**: 164:45:69

**Signature:**
```solidity
function warp(uint256 newTimestamp) external;;
```

### roll(uint256)

- **Signature**: `roll(uint256)`
- **Visibility**: external
- **Source Range**: 252:42:69

**Signature:**
```solidity
function roll(uint256 newNumber) external;;
```

### assume(bool)

- **Signature**: `assume(bool)`
- **Visibility**: external
- **Source Range**: 425:33:69

**Signature:**
```solidity
function assume(bool b) external;;
```

### deal(address,uint256)

- **Signature**: `deal(address,uint256)`
- **Visibility**: external
- **Source Range**: 506:49:69

**Signature:**
```solidity
function deal(address usr, uint256 amt) external;;
```

### load(address,bytes32)

- **Signature**: `load(address,bytes32)`
- **Visibility**: external
- **Source Range**: 605:70:69

**Signature:**
```solidity
function load(address where, bytes32 slot) external returns (bytes32);;
```

### store(address,bytes32,bytes32)

- **Signature**: `store(address,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 731:68:69

**Signature:**
```solidity
function store(address where, bytes32 slot, bytes32 value) external;;
```

### sign(uint256,bytes32)

- **Signature**: `sign(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 857:99:69

**Signature:**
```solidity
function sign(uint256 privateKey, bytes32 digest) external returns (uint8 v, bytes32 r, bytes32 s);;
```

### addr(uint256)

- **Signature**: `addr(uint256)`
- **Visibility**: external
- **Source Range**: 1006:66:69

**Signature:**
```solidity
function addr(uint256 privateKey) external returns (address addr);;
```

### ffi(string[])

- **Signature**: `ffi(string[])`
- **Visibility**: external
- **Source Range**: 1131:78:69

**Signature:**
```solidity
function ffi(string[] calldata inputs) external returns (bytes memory result);;
```

### prank(address)

- **Signature**: `prank(address)`
- **Visibility**: external
- **Source Range**: 1288:43:69

**Signature:**
```solidity
function prank(address newSender) external;;
```

### createFork(string)

- **Signature**: `createFork(string)`
- **Visibility**: external
- **Source Range**: 1447:75:69

**Signature:**
```solidity
function createFork(string calldata urlOrAlias) external returns (uint256);;
```

### selectFork(uint256)

- **Signature**: `selectFork(uint256)`
- **Visibility**: external
- **Source Range**: 1631:45:69

**Signature:**
```solidity
function selectFork(uint256 forkId) external;;
```

### activeFork()

- **Signature**: `activeFork()`
- **Visibility**: external
- **Source Range**: 1732:49:69

**Signature:**
```solidity
function activeFork() external returns (uint256);;
```

### label(address,string)

- **Signature**: `label(address,string)`
- **Visibility**: external
- **Source Range**: 1823:61:69

**Signature:**
```solidity
function label(address addr, string calldata label) external;;
```

### etch(address,bytes)

- **Signature**: `etch(address,bytes)`
- **Visibility**: external
- **Source Range**: 1921:74:69

**Signature:**
```solidity
/// Sets an address' code.
function etch(address target, bytes calldata newRuntimeBytecode) external;;
```
