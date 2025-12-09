# Function: isActivePPSOracle(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `isActivePPSOracle(address)`
- **Visibility**: external
- **Source Range**: 30776:122:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function isActivePPSOracle(address oracle) external view returns (bool) {
    return oracle == _activePPSOracle;
}
```

## State Variable Reads

- **_activePPSOracle** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.isActivePPSOracle(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Checks if an address is the current active PPS oracle
 @param oracle The address to check
 @return True if the address is the active PPS oracle, false otherwise
