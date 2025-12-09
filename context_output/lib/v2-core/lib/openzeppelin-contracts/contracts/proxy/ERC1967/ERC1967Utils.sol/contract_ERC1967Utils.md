# Contract: ERC1967Utils

## Metadata

- **Name**: ERC1967Utils
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol
- **Documentation**:  @dev This library provides getters and event emitting update functions for
   https://eips.ethereum.org/EIPS/eip-1967[ERC-1967] slots.

## State Variables

### IMPLEMENTATION_SLOT

```solidity
///  @dev Storage slot with the address of the current implementation.
///  This is the keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1.
bytes32 internal constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
```

### ADMIN_SLOT

```solidity
///  @dev Storage slot with the admin of the contract.
///  This is the keccak-256 hash of "eip1967.proxy.admin" subtracted by 1.
bytes32 internal constant ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
```

### BEACON_SLOT

```solidity
///  @dev The storage slot of the UpgradeableBeacon contract which defines the implementation for this proxy.
///  This is the keccak-256 hash of "eip1967.proxy.beacon" subtracted by 1.
bytes32 internal constant BEACON_SLOT = 0xa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50
```

## Errors

### ERC1967InvalidImplementation

```solidity
///  @dev The `implementation` of the proxy is invalid.
error ERC1967InvalidImplementation(address implementation);
```

### ERC1967InvalidAdmin

```solidity
///  @dev The `admin` of the proxy is invalid.
error ERC1967InvalidAdmin(address admin);
```

### ERC1967InvalidBeacon

```solidity
///  @dev The `beacon` of the proxy is invalid.
error ERC1967InvalidBeacon(address beacon);
```

### ERC1967NonPayable

```solidity
///  @dev An upgrade function sees `msg.value > 0` that may be lost.
error ERC1967NonPayable();
```
