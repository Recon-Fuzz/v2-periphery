# Function: queueProviderRemoval(bytes32[])

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `queueProviderRemoval(bytes32[])`
- **Visibility**: external
- **Source Range**: 7555:565:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function queueProviderRemoval(bytes32[] calldata providers) external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    if (pendingRemoval.timestamp != 0) revert PENDING_UPDATE_EXISTS();
    uint256 length = providers.length;
    if (length == 0) revert ZERO_ARRAY_LENGTH();
    if (length > MAX_PROVIDER_REMOVALS) revert TOO_MANY_PROVIDERS();
    pendingRemoval = PendingRemoval({providers: providers, timestamp: block.timestamp});
    emit ProviderRemovalQueued(providers, block.timestamp);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)
- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)
- **MAX_PROVIDER_REMOVALS** (`uint256`)

## State Variable Writes

- **pendingRemoval** (`struct ISuperOracle.PendingRemoval`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.queueProviderRemoval(bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Queue provider removal for timelock
 @param providers Array of provider ids to remove
