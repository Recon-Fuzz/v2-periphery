# Function: setPreviewSharesGreater(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `setPreviewSharesGreater(uint256)`
- **Visibility**: public
- **Source Range**: 11994:500:630
- **Inherited From**: Properties

## Implementation

```solidity
function setPreviewSharesGreater(uint256 assets) public {
    uint256 previewDepositShares = superVault.previewDeposit(assets);
    uint256 previewMintShares = superVault.previewMint(previewDepositShares);
    if (previewDepositShares > previewMintShares) {
        previewDepositSharesGreater = int256(previewDepositShares) - int256(previewMintShares);
    } else {
        previewMintSharesGreater = int256(previewMintShares) - int256(previewDepositShares);
    }
}
```

## External Calls

- **SuperVault::previewDeposit(uint256)**
- **SuperVault::previewMint(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.setPreviewSharesGreater(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
