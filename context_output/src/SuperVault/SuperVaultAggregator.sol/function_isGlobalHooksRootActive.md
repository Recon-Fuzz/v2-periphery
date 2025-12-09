# Function: isGlobalHooksRootActive()

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `isGlobalHooksRootActive()`
- **Visibility**: external
- **Source Range**: 50478:170:511

## Implementation

```solidity
/// @notice Checks if the global hooks root is active (timelock period has passed)
///  @return isActive True if the global hooks root is active
function isGlobalHooksRootActive() external view returns (bool) {
    return (block.timestamp >= _globalHooksRootEffectiveTime) && (_globalHooksRoot != bytes32(0));
}
```

## State Variable Reads

- **_globalHooksRootEffectiveTime** (`uint256`)
- **_globalHooksRoot** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.isGlobalHooksRootActive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Checks if the global hooks root is active (timelock period has passed)
 @return isActive True if the global hooks root is active

### Interface Documentation

@notice Checks if the global hooks root is active (timelock period has passed)
 @return isActive True if the global hooks root is active
