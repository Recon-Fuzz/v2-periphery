# Function: decodeUsePrevHookAmount(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/uniswap-v4/SwapUniswapV4Hook.sol/contract_SwapUniswapV4Hook.md]

## Metadata

- **Contract**: SwapUniswapV4Hook
- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 20638:243:394

## Implementation

```solidity
/// @notice Decodes the usePrevHookAmount flag from hook data
///  @param data The encoded hook data
///  @return usePrevHookAmount Whether to use the previous hook's output amount
function decodeUsePrevHookAmount(bytes calldata data) external pure returns (bool usePrevHookAmount) {
    if (data.length < 218) {
        revert INVALID_HOOK_DATA();
    }
    usePrevHookAmount = _decodeBool(data, 217);
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SwapUniswapV4Hook.decodeUsePrevHookAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 1)
      💬 Args: [data, 217]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Decodes the usePrevHookAmount flag from hook data
 @param data The encoded hook data
 @return usePrevHookAmount Whether to use the previous hook's output amount
