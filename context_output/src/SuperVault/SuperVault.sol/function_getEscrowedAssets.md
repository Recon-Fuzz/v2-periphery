# Function: getEscrowedAssets()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `getEscrowedAssets()`
- **Visibility**: external
- **Source Range**: 12509:109:510

## Implementation

```solidity
/// @inheritdoc ISuperVault
function getEscrowedAssets() external view returns (uint256) {
    return _asset.balanceOf(escrow);
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **escrow** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.getEscrowedAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVault

### Interface Documentation

@notice Get the amount of assets escrowed
