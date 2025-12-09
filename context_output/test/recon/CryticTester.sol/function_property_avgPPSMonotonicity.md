# Function: property_avgPPSMonotonicity()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
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

## State Variable Reads

- **_actor** (`address`)

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
  └─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 3)
      💬 Args: [_after.state[_getActor()].averageRequestPPS, _before.state[_getActor()].averageRequestPPS, "averageWithdrawPrice should not decrease when fulfilled at a higher PPS"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: averageWithdrawPrice should never decrease when new redemptions are fulfilled at a higher PPS
