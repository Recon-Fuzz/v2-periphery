# Function: property_totalSharesDontDecreaseOnRedemptionRequest()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `property_totalSharesDontDecreaseOnRedemptionRequest()`
- **Visibility**: public
- **Source Range**: 1693:317:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: requestRedeem should never reduce SuperVault shares
function property_totalSharesDontDecreaseOnRedemptionRequest() public {
    if (_currentOp == OpType.REQUEST) {
        eq(_before.summedTotalShares, _after.summedTotalShares, "requestRedeem should never reduce SuperVault shares");
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

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_totalSharesDontDecreaseOnRedemptionRequest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [_before.summedTotalShares, _after.summedTotalShares, "requestRedeem should never reduce SuperVault shares"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: requestRedeem should never reduce SuperVault shares
