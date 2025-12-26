# Function: getVaultInfo()

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `getVaultInfo()`
- **Visibility**: external
- **Source Range**: 24177:202:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function getVaultInfo() external view returns (address vault, address asset, uint8 vaultDecimals) {
    vault = _vault;
    asset = address(_asset);
    vaultDecimals = _vaultDecimals;
}
```

## State Variable Reads

- **_vault** (`address`)
- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_vaultDecimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.getVaultInfo() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Get the vault info
