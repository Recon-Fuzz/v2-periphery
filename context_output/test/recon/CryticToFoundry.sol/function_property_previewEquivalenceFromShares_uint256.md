# Function: property_previewEquivalenceFromShares(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
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
- **Source**: 695:121:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertEq(a, b, reason);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **SuperVault::previewDeposit(uint256)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_previewEquivalenceFromShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [shares, previewDepositShares, "previewMint and previewDeposit equivalence (from shares)"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and previewDeposit equivalence (from shares)
