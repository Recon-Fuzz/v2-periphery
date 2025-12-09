# Function: property_fulfillOnlyBurnsRequestedAmount()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `property_fulfillOnlyBurnsRequestedAmount()`
- **Visibility**: public
- **Source Range**: 10754:760:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: redemptions only burn the requested amount of shares (within tolerance range)
function property_fulfillOnlyBurnsRequestedAmount() public {
    if (_currentOp == OpType.FULFILL) {
        uint256 pendingRedeemDelta = _before.summedPendingRedeem - _after.summedPendingRedeem;
        uint256 totalSupplyDelta = _before.summedTotalShares - _after.summedTotalShares;
        if (totalSupplyDelta < pendingRedeemDelta) {
            gte(totalSupplyDelta, pendingRedeemDelta, "burned less than requested beyond tolerance");
        } else {
            lte(totalSupplyDelta, pendingRedeemDelta, "burned more than requested beyond tolerance");
        }
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

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_fulfillOnlyBurnsRequestedAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [totalSupplyDelta, pendingRedeemDelta, "burned less than requested beyond tolerance"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 2)
  │     💬 Args: [a, b, reason]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.lte(uint256,uint256,string) (NodeID: 3)
      💬 Args: [totalSupplyDelta, pendingRedeemDelta, "burned more than requested beyond tolerance"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertLe(uint256,uint256,string) (NodeID: 4)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: redemptions only burn the requested amount of shares (within tolerance range)
