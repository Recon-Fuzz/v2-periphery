# Function: decodeUsePrevHookAmount(bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 1240:153:375
- **Inherited From**: BaseLoanHook

## Implementation

```solidity
/// @inheritdoc ISuperHookContextAware
function decodeUsePrevHookAmount(bytes memory data) external pure returns (bool) {
    return _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
}
```

## Related Implementations

### _decodeBool(bytes,uint256)

- **Kind**: internal
- **Source**: 11462:126:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_decodeBool(bytes,uint256)`

```solidity
/// @notice Decodes a boolean value from a byte array at the specified offset
///  @dev Helper function for extracting boolean values from packed data
///       Used when parsing hook-specific data parameters
///  @param data The byte array containing the encoded data
///  @param offset The position in the array to read from
///  @return The decoded boolean value (true if byte is non-zero)
function _decodeBool(bytes memory data, uint256 offset) internal pure returns (bool) {
    return data[offset] != 0;
}
```

## State Variable Reads

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseLoanHook.decodeUsePrevHookAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 1)
      💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookContextAware

### Interface Documentation

@notice Determines if this hook should use the amount from the previous hook
 @dev Used to create hook chains where output from one hook becomes input to the next
 @param data The hook-specific data containing configuration
 @return True if the hook should use the previous hook's output amount
