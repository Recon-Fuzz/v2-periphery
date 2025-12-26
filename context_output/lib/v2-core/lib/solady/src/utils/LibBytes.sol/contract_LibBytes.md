# Contract: LibBytes

## Metadata

- **Name**: LibBytes
- **Type**: Contract
- **Path**: lib/v2-core/lib/solady/src/utils/LibBytes.sol
- **Documentation**: @notice Library for byte related operations.
   @author Solady (https://github.com/vectorized/solady/blob/main/src/utils/LibBytes.sol)

## State Variables

### NOT_FOUND

```solidity
/// @dev The constant returned when the `search` is not found in the bytes.
uint256 internal constant NOT_FOUND = type(uint256).max
```

## Structs

### BytesStorage

```solidity
/// @dev Goated bytes storage struct that totally MOGs, no cap, fr.
///  Uses less gas and bytecode than Solidity's native bytes storage. It's meta af.
///  Packs length with the first 31 bytes if <255 bytes, so it’s mad tight.
struct BytesStorage {
    bytes32 _spacer;
}
```
