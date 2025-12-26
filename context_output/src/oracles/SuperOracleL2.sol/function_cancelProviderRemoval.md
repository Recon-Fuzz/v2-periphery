# Function: cancelProviderRemoval()

**Contract**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Metadata

- **Contract**: SuperOracleL2
- **Signature**: `cancelProviderRemoval()`
- **Visibility**: external
- **Source Range**: 9505:368:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function cancelProviderRemoval() external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    if (pendingRemoval.timestamp == 0) revert NO_PENDING_UPDATE();
    bytes32[] memory cancelledProviders = pendingRemoval.providers;
    delete pendingRemoval;
    emit ProviderRemovalCancelled(cancelledProviders);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)

## State Variable Writes

- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.cancelProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Cancel queued provider removal
