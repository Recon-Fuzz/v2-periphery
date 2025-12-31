# Contract: SafeCast

## Metadata

- **Name**: SafeCast
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol
- **Documentation**:  @dev Wrappers over Solidity's uintXX/intXX/bool casting operators with added overflow
   checks.
   Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
   easily result in undesired exploitation or bugs, since developers usually
   assume that overflows raise errors. `SafeCast` restores this intuition by
   reverting the transaction when such an operation overflows.
   Using this library instead of the unchecked operations eliminates an entire
   class of bugs, so it's recommended to use it always.

## Errors

### SafeCastOverflowedUintDowncast

```solidity
///  @dev Value doesn't fit in an uint of `bits` size.
error SafeCastOverflowedUintDowncast(uint8 bits, uint256 value);
```

### SafeCastOverflowedIntToUint

```solidity
///  @dev An int value doesn't fit in an uint of `bits` size.
error SafeCastOverflowedIntToUint(int256 value);
```

### SafeCastOverflowedIntDowncast

```solidity
///  @dev Value doesn't fit in an int of `bits` size.
error SafeCastOverflowedIntDowncast(uint8 bits, int256 value);
```

### SafeCastOverflowedUintToInt

```solidity
///  @dev An uint value doesn't fit in an int of `bits` size.
error SafeCastOverflowedUintToInt(uint256 value);
```
