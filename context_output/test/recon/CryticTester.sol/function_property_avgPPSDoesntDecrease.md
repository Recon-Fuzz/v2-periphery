# Function: property_avgPPSDoesntDecrease()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_avgPPSDoesntDecrease()`
- **Visibility**: public
- **Source Range**: 4976:560:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: When a user requests a redemption and the PPS is >= the user PPS, user averageRequestPPS must not
///  decrease
function property_avgPPSDoesntDecrease() public {
    uint256 currentPrice = _before.oraclePPS;
    uint256 beforeAvgPPS = _before.state[_getActor()].averageRequestPPS;
    uint256 afterAvgPPS = _after.state[_getActor()].averageRequestPPS;
    if ((_currentOp == OpType.REQUEST) && (currentPrice >= beforeAvgPPS)) {
        gte(afterAvgPPS, beforeAvgPPS, "when a user requests a redemption and the PPS is >= the user PPS, user averageRequestPPS must not decrease");
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
┌─ [0] ⚙️ FUNCTION: Properties.property_avgPPSDoesntDecrease() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 3)
      💬 Args: [afterAvgPPS, beforeAvgPPS, "when a user requests a redemption and the PPS is >= the user PPS, user averageRequestPPS must not decrease"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: When a user requests a redemption and the PPS is >= the user PPS, user averageRequestPPS must not
 decrease
