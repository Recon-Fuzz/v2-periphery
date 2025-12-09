# Function: doomsday_previewDepositEquivalence(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `doomsday_previewDepositEquivalence(uint256)`
- **Visibility**: public
- **Source Range**: 964:357:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Property: previewDeposit and deposit equivalence
function doomsday_previewDepositEquivalence(uint256 assets) public {
    uint256 previewDepositShares = superVault.previewDeposit(assets);
    vm.prank(_getActor());
    uint256 sharesActualDeposit = superVault.deposit(assets, _getActor());
    eq(previewDepositShares, sharesActualDeposit, "previewDeposit and deposit equivalence");
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

- **SuperVault::previewDeposit(uint256)**
- **Vm::prank(address)**
- **SuperVault::deposit(uint256,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.doomsday_previewDepositEquivalence(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [previewDepositShares, sharesActualDeposit, "previewDeposit and deposit equivalence"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewDeposit and deposit equivalence
