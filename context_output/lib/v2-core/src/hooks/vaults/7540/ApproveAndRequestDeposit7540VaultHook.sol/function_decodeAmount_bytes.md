# Function: decodeAmount(bytes)

**Contract**: [lib/v2-core/src/hooks/vaults/7540/ApproveAndRequestDeposit7540VaultHook.sol/contract_ApproveAndRequestDeposit7540VaultHook.md]

## Metadata

- **Contract**: ApproveAndRequestDeposit7540VaultHook
- **Signature**: `decodeAmount(bytes)`
- **Visibility**: external
- **Source Range**: 3450:116:405

## Implementation

```solidity
/// @inheritdoc ISuperHookInflowOutflow
function decodeAmount(bytes memory data) external pure returns (uint256) {
    return _decodeAmount(data);
}
```

## Related Implementations

### _decodeAmount(bytes)

- **Kind**: internal
- **Source**: 4765:138:405
- **Link**: `lib/v2-core/src/hooks/vaults/7540/ApproveAndRequestDeposit7540VaultHook.sol:ApproveAndRequestDeposit7540VaultHook:_decodeAmount(bytes)`

```solidity
function _decodeAmount(bytes memory data) private pure returns (uint256) {
    return BytesLib.toUint256(data, AMOUNT_POSITION);
}
```

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
}
```

## State Variable Reads

- **AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ApproveAndRequestDeposit7540VaultHook.decodeAmount(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ApproveAndRequestDeposit7540VaultHook._decodeAmount(bytes) (NodeID: 1)
      💬 Args: [data]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
        💬 Args: [data, AMOUNT_POSITION]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInflowOutflow

### Interface Documentation

@notice Extracts the amount from the hook's calldata
 @dev Used to determine the quantity of assets or shares being processed
 @param data The hook-specific calldata containing the amount
 @return The amount of tokens to process
