# Function: property_comparePreviewDepositAndConvertToShares(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `property_comparePreviewDepositAndConvertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 7989:423:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: convertToShares is >= previewDepositShares (equivalent without fees)
function property_comparePreviewDepositAndConvertToShares(uint256 assets) public {
    uint256 previewDepositShares = superVault.previewDeposit(assets);
    uint256 convertToShares = superVault.convertToShares(assets);
    gte(convertToShares, previewDepositShares, "convertToShares is higher than or equal to previewDepositShares (equivalent without fees)");
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

- **SuperVault::previewDeposit(uint256)**
- **SuperVault::convertToShares(uint256)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_comparePreviewDepositAndConvertToShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 1)
      💬 Args: [convertToShares, previewDepositShares, "convertToShares is higher than or equal to previewDepositShares (equivalent without fees)"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 2)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: convertToShares is >= previewDepositShares (equivalent without fees)
