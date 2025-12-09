# Function: superVaultStrategy_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVaultStrategy_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)`
- **Visibility**: public
- **Source Range**: 1816:254:653
- **Inherited From**: SuperVaultStrategyTargets

## Implementation

```solidity
function superVaultStrategy_manageYieldSource(address source, address oracle, ISuperVaultStrategy.YieldSourceAction actionType) public asActor() {
    superVaultStrategy.manageYieldSource(source, oracle, actionType);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 5892:77:631
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

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

## External Calls

- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategyTargets.superVaultStrategy_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
