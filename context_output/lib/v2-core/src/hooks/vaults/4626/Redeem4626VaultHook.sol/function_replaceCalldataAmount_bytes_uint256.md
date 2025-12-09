# Function: replaceCalldataAmount(bytes,uint256)

**Contract**: [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]

## Metadata

- **Contract**: Redeem4626VaultHook
- **Signature**: `replaceCalldataAmount(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 3300:180:401

## Implementation

```solidity
/// @inheritdoc ISuperHookOutflow
function replaceCalldataAmount(bytes memory data, uint256 amount) external pure returns (bytes memory) {
    return _replaceCalldataAmount(data, amount, AMOUNT_POSITION);
}
```

## Related Implementations

### _replaceCalldataAmount(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 12186:373:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_replaceCalldataAmount(bytes,uint256,uint256)`

```solidity
/// @notice Replaces an amount value within a byte array at the specified offset
///  @dev Used to modify hook calldata for amount adjustments without full re-encoding
///       Particularly useful for modifying amounts in multi-hook execution chains
///       Directly modifies the bytes in-place for gas efficiency
///  @param data The original byte array containing encoded calldata
///  @param amount The new amount value to insert
///  @param offset The position in the array where the amount starts
///  @return The modified byte array with the replaced amount
function _replaceCalldataAmount(bytes memory data, uint256 amount, uint256 offset) internal pure returns (bytes memory) {
    bytes memory newAmountEncoded = abi.encodePacked(amount);
    for (uint256 i; i < 32; ++i) {
        data[offset + i] = newAmountEncoded[i];
    }
    return data;
}
```

## State Variable Reads

- **AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Redeem4626VaultHook.replaceCalldataAmount(bytes,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseHook._replaceCalldataAmount(bytes,uint256,uint256) (NodeID: 1)
      💬 Args: [data, amount, AMOUNT_POSITION]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookOutflow

### Interface Documentation

@notice Replace the amount in the calldata
 @param data The data to replace the amount in
 @param amount The amount to replace
 @return data The data with the replaced amount
