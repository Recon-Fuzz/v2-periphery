# Function: superVaultAggregator_removeSecondaryManager(address,address)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superVaultAggregator_removeSecondaryManager(address,address)`
- **Visibility**: public
- **Source Range**: 3934:204:651
- **Inherited From**: SuperVaultAggregatorTargets

## Implementation

```solidity
/// @dev removed because we're bypassing hook validation
function superVaultAggregator_removeSecondaryManager(address strategy, address manager) public asActor() {
    superVaultAggregator.removeSecondaryManager(strategy, manager);
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

- **UnsafeSuperVaultAggregator::removeSecondaryManager(address,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTargets.superVaultAggregator_removeSecondaryManager(address,address) (NodeID: 0)
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

@dev removed because we're bypassing hook validation
