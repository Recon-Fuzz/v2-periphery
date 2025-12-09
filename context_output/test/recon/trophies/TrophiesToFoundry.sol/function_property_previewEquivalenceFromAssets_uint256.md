# Function: property_previewEquivalenceFromAssets(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `property_previewEquivalenceFromAssets(uint256)`
- **Visibility**: public
- **Source Range**: 6380:897:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: previewMint and previewDeposit equivalence (from assets)
function property_previewEquivalenceFromAssets(uint256 assets) public {
    uint256 previewDepositShares = superVault.previewDeposit(assets);
    uint256 previewMintAssets_under = superVault.previewMint(previewDepositShares);
    uint256 previewMintAssets_over = superVault.previewMint(previewDepositShares + 1);
    uint256 price = superVaultStrategy.getStoredPPS();
    ISuperVaultStrategy.FeeConfig memory cfg = superVaultStrategy.getConfigInfo();
    if (cfg.managementFeeBps >= 10_000) return;
    if (price > 0) {
        gte(assets, previewMintAssets_under, "previewMint and previewDeposit equivalence under (from assets)");
        lte(assets, previewMintAssets_over, "previewMint and previewDeposit equivalence over (from assets)");
    }
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

### lte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 567:122:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:lte(uint256,uint256,string)`

```solidity
function lte(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertLe(a, b, reason);
}
```

### assertLe(uint256,uint256,string)

- **Kind**: internal
- **Source**: 16150:176:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLe(uint256,uint256,string)`

```solidity
function assertLe(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left > right) {
        vm.assertLe(left, right, err);
    }
}
```

## External Calls

- **SuperVault::previewDeposit(uint256)**
- **SuperVault::previewMint(uint256)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_previewEquivalenceFromAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [assets, previewMintAssets_under, "previewMint and previewDeposit equivalence under (from assets)"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 2)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.lte(uint256,uint256,string) (NodeID: 3)
      💬 Args: [assets, previewMintAssets_over, "previewMint and previewDeposit equivalence over (from assets)"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 4)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and previewDeposit equivalence (from assets)
