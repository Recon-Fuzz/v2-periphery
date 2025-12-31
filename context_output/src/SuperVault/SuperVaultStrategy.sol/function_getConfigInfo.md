# Function: getConfigInfo()

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `getConfigInfo()`
- **Visibility**: external
- **Source Range**: 24425:116:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function getConfigInfo() external view returns (FeeConfig memory feeConfig_) {
    feeConfig_ = feeConfig;
}
```

## State Variable Reads

- **feeConfig** (`struct ISuperVaultStrategy.FeeConfig`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.getConfigInfo() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the fee configurations
