# Function: getActiveProviders()

**Contract**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

## Metadata

- **Contract**: SuperOracle
- **Signature**: `getActiveProviders()`
- **Visibility**: external
- **Source Range**: 9912:110:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function getActiveProviders() external view returns (bytes32[] memory) {
    return activeProviders;
}
```

## State Variable Reads

- **activeProviders** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.getActiveProviders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Get all active provider ids
 @return Array of active provider ids
