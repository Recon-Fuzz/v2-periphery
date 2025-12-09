# Function: setpreviewAssetsGreater(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `setpreviewAssetsGreater(uint256)`
- **Visibility**: public
- **Source Range**: 11550:438:630
- **Inherited From**: Properties

## Implementation

```solidity
/// Optimization Setters
function setpreviewAssetsGreater(uint256 shares) public {
    uint256 previewMintAssets = superVault.previewMint(shares);
    uint256 previewDepositAssets = superVault.previewDeposit(previewMintAssets);
    if (previewMintAssets > previewDepositAssets) {
        previewMintAssetsGreater = int256(previewMintAssets);
    } else {
        previewDepositAssetsGreater = int256(previewDepositAssets);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::previewDeposit(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.setpreviewAssetsGreater(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

Optimization Setters
