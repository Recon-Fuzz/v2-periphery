# Function: property_comparePreviewMintAndConvertToAssets(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_comparePreviewMintAndConvertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 7340:551:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: previewMint is >= convertToAssets
function property_comparePreviewMintAndConvertToAssets(uint256 shares) public {
    uint256 previewMintAssets = superVault.previewMint(shares);
    uint256 convertToAssets = superVault.convertToAssets(shares);
    ISuperVaultStrategy.FeeConfig memory cfg = superVaultStrategy.getConfigInfo();
    if (cfg.managementFeeBps >= 10_000) return;
    gte(previewMintAssets, convertToAssets, "previewMint is >= convertToAssets");
}
```

## Related Implementations

### gte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 347:182:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a >= b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::convertToAssets(uint256)**
- **SuperVaultStrategy::getConfigInfo()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_comparePreviewMintAndConvertToAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 1)
      💬 Args: [previewMintAssets, convertToAssets, "previewMint is >= convertToAssets"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint is >= convertToAssets
