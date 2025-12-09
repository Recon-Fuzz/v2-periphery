# Function: superVaultStrategy_proposeVaultFeeConfigUpdate(uint256,uint256,address)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superVaultStrategy_proposeVaultFeeConfigUpdate(uint256,uint256,address)`
- **Visibility**: public
- **Source Range**: 2371:330:653
- **Inherited From**: SuperVaultStrategyTargets

## Implementation

```solidity
function superVaultStrategy_proposeVaultFeeConfigUpdate(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient) public asActor() {
    superVaultStrategy.proposeVaultFeeConfigUpdate(performanceFeeBps, managementFeeBps, recipient);
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

- **SuperVaultStrategy::proposeVaultFeeConfigUpdate(uint256,uint256,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategyTargets.superVaultStrategy_proposeVaultFeeConfigUpdate(uint256,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
