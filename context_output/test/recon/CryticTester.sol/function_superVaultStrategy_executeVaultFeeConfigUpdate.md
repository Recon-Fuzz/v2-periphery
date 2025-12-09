# Function: superVaultStrategy_executeVaultFeeConfigUpdate()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVaultStrategy_executeVaultFeeConfigUpdate()`
- **Visibility**: public
- **Source Range**: 730:138:653
- **Inherited From**: SuperVaultStrategyTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultStrategy_executeVaultFeeConfigUpdate() public asActor() {
    superVaultStrategy.executeVaultFeeConfigUpdate();
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

- **SuperVaultStrategy::executeVaultFeeConfigUpdate()**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategyTargets.superVaultStrategy_executeVaultFeeConfigUpdate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
