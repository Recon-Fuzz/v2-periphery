# Function: validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[])`
- **Visibility**: external
- **Source Range**: 46072:400:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function validateHooks(address, ValidateHookArgs[] calldata argsArray) external pure returns (bool[] memory validHooks) {
    uint256 length = argsArray.length;
    validHooks = new bool[](length);
    for (uint256 i; i < length; i++) {
        validHooks[i] = true;
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.validateHooks(address,struct ISuperVaultAggregator.ValidateHookArgs[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Batch validates multiple hooks against Merkle roots
 @param strategy Address of the strategy
 @param argsArray Array of hook validation arguments
 @return validHooks Array of booleans indicating which hooks are valid
