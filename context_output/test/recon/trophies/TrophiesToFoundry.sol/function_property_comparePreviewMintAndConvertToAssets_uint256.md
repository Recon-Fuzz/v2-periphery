# Function: property_comparePreviewMintAndConvertToAssets(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
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
- **Source**: 312:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertGe(a, b, reason);
}
```

### assertGe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 17502:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGe(uint256,uint256,string)`

```solidity
function assertGe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left < right) {
        vm.assertGe(left, right, err);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::convertToAssets(uint256)**
- **SuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_comparePreviewMintAndConvertToAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 1)
      💬 Args: [previewMintAssets, convertToAssets, "previewMint is >= convertToAssets"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 2)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint is >= convertToAssets
