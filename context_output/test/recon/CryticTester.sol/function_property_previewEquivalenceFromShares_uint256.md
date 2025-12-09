# Function: property_previewEquivalenceFromShares(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_previewEquivalenceFromShares(uint256)`
- **Visibility**: public
- **Source Range**: 5622:672:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: previewMint and previewDeposit equivalence (from shares)
function property_previewEquivalenceFromShares(uint256 shares) public {
    uint256 previewMintAssets = superVault.previewMint(shares);
    uint256 previewDepositShares = superVault.previewDeposit(previewMintAssets);
    uint256 price = superVaultStrategy.getStoredPPS();
    ISuperVaultStrategy.FeeConfig memory cfg = superVaultStrategy.getConfigInfo();
    if (cfg.managementFeeBps >= 10_000) return;
    if (price > 0) {
        eq(shares, previewDepositShares, "previewMint and previewDeposit equivalence (from shares)");
    }
}
```

## Related Implementations

### eq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 909:181:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a == b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::previewDeposit(uint256)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultStrategy::getConfigInfo()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_previewEquivalenceFromShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [shares, previewDepositShares, "previewMint and previewDeposit equivalence (from shares)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and previewDeposit equivalence (from shares)
