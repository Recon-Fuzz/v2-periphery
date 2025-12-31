# Function: getGasInfo(address)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getGasInfo(address)`
- **Visibility**: external
- **Source Range**: 31092:114:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function getGasInfo(address oracle_) external view returns (uint256) {
    return _gasPerEntry[oracle_];
}
```

## State Variable Reads

- **_gasPerEntry** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getGasInfo(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets the gas info for a specific SuperVault PPS Oracle
 @param oracle_ The address of the oracle to get gas info for
 @return The gas info for the specified oracle
