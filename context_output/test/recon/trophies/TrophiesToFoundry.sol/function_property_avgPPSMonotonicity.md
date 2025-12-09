# Function: property_avgPPSMonotonicity()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `property_avgPPSMonotonicity()`
- **Visibility**: public
- **Source Range**: 10021:626:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: averageWithdrawPrice should never decrease when new redemptions are fulfilled at a higher PPS
function property_avgPPSMonotonicity() public {
    if (((_currentOp == OpType.FULFILL) && (_before.oraclePPS > _before.state[_getActor()].averageRequestPPS)) && (_after.state[_getActor()].pendingRedeemRequest != 0)) {
        gte(_after.state[_getActor()].averageRequestPPS, _before.state[_getActor()].averageRequestPPS, "averageWithdrawPrice should not decrease when fulfilled at a higher PPS");
    }
}
```

## Related Implementations

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

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

## State Variable Reads

- **_actor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_avgPPSMonotonicity() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.gte(uint256,uint256,string) (NodeID: 3)
      💬 Args: [_after.state[_getActor()].averageRequestPPS, _before.state[_getActor()].averageRequestPPS, "averageWithdrawPrice should not decrease when fulfilled at a higher PPS"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertGe(uint256,uint256,string) (NodeID: 4)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: averageWithdrawPrice should never decrease when new redemptions are fulfilled at a higher PPS
