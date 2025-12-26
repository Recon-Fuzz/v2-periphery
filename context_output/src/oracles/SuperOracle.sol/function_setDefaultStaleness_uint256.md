# Function: setDefaultStaleness(uint256)

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `setDefaultStaleness(uint256)`
- **Visibility**: external
- **Source Range**: 4654:247:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function setDefaultStaleness(uint256 newMaxStaleness) external {
    if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY();
    defaultStaleness = newMaxStaleness;
    emit MaxStalenessUpdated(newMaxStaleness);
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`address`)

## State Variable Writes

- **defaultStaleness** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.setDefaultStaleness(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Set the maximum staleness period for all providers
 @param newMaxStaleness New maximum staleness period in seconds
