# Function: executeProviderRemoval()

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 8159:1307:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function executeProviderRemoval() external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    if (pendingRemoval.timestamp == 0) revert NO_PENDING_UPDATE();
    if (block.timestamp < (pendingRemoval.timestamp + REMOVAL_TIMELOCK_PERIOD)) revert TIMELOCK_NOT_ELAPSED();
    bytes32[] memory providersToRemove = pendingRemoval.providers;
    for (uint256 i; i < providersToRemove.length; i++) {
        bytes32 providerToRemove = providersToRemove[i];
        isProviderSet[providerToRemove] = false;
        for (uint256 j; j < activeProviders.length; j++) {
            if (activeProviders[j] == providerToRemove) {
                if (j < (activeProviders.length - 1)) {
                    activeProviders[j] = activeProviders[activeProviders.length - 1];
                }
                activeProviders.pop();
                break;
            }
        }
    }
    emit ProviderRemovalExecuted(providersToRemove);
    delete pendingRemoval;
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)
- **REMOVAL_TIMELOCK_PERIOD** (`uint256`)
- **activeProviders** (`bytes32[]`)

## State Variable Writes

- **isProviderSet** (`mapping(bytes32 => bool)`)
- **activeProviders** (`bytes32[]`)
- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.executeProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Execute queued provider removal after timelock period
