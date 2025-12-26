# Function: previewExactRedeemBatch(address[])

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `previewExactRedeemBatch(address[])`
- **Visibility**: external
- **Source Range**: 29075:704:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function previewExactRedeemBatch(address[] calldata controllers) external view returns (uint256 totalTheoAssets, uint256[] memory individualAssets) {
    if (controllers.length == 0) revert ZERO_LENGTH();
    individualAssets = new uint256[](controllers.length);
    totalTheoAssets = 0;
    for (uint256 i = 0; i < controllers.length; i++) {
        (, uint256 theoreticalAssets, ) = this.previewExactRedeem(controllers[i]);
        individualAssets[i] = theoreticalAssets;
        totalTheoAssets += theoreticalAssets;
    }
    return (totalTheoAssets, individualAssets);
}
```

## External Calls

- **SuperVaultStrategy::previewExactRedeem(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.previewExactRedeemBatch(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Batch preview exact redeem fulfillment for multiple controllers
 @dev Efficiently batches multiple previewExactRedeem calls to reduce RPC overhead
 @param controllers Array of controller addresses to preview
 @return totalTheoAssets Total theoretical assets across all controllers
 @return individualAssets Array of theoretical assets per controller
