# Function: property_previewEquivalenceFromAssets(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
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

### lte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 721:182:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:lte(uint256,uint256,string)`

```solidity
function lte(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a <= b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **SuperVault::previewDeposit(uint256)**
- **SuperVault::previewMint(uint256)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultStrategy::getConfigInfo()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_previewEquivalenceFromAssets(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [assets, previewMintAssets_under, "previewMint and previewDeposit equivalence under (from assets)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.lte(uint256,uint256,string) (NodeID: 2)
      💬 Args: [assets, previewMintAssets_over, "previewMint and previewDeposit equivalence over (from assets)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and previewDeposit equivalence (from assets)
