# Contract: ShortStrings

## Metadata

- **Name**: ShortStrings
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol
- **Documentation**:  @dev This library provides functions to convert short memory strings
   into a `ShortString` type that can be used as an immutable variable.
   Strings of arbitrary length can be optimized using this library if
   they are short enough (up to 31 bytes) by packing them with their
   length (1 byte) in a single EVM word (32 bytes). Additionally, a
   fallback mechanism can be used for every other case.
   Usage example:
   ```solidity
   contract Named {
       using ShortStrings for *;
       ShortString private immutable _name;
       string private _nameFallback;
       constructor(string memory contractName) {
           _name = contractName.toShortStringWithFallback(_nameFallback);
       }
       function name() external view returns (string memory) {
           return _name.toStringWithFallback(_nameFallback);
       }
   }
   ```

## State Variables

### FALLBACK_SENTINEL

```solidity
bytes32 private constant FALLBACK_SENTINEL = 0x00000000000000000000000000000000000000000000000000000000000000FF
```

## Errors

### StringTooLong

```solidity
error StringTooLong(string str);
```

### InvalidShortString

```solidity
error InvalidShortString();
```
