# Function: getPPSOracleQuorum()

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getPPSOracleQuorum()`
- **Visibility**: external
- **Source Range**: 30408:109:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getPPSOracleQuorum() external view returns (uint256) {
    return _validatorConfig.quorum;
}
```

## State Variable Reads

- **_validatorConfig** (`struct SuperGovernor.ValidatorConfig`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getPPSOracleQuorum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the current quorum requirement for the active PPS Oracle
 @return The current quorum requirement
