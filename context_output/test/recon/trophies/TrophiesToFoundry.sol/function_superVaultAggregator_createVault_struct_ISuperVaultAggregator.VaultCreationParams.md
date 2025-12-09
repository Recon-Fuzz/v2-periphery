# Function: superVaultAggregator_createVault(struct ISuperVaultAggregator.VaultCreationParams)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `superVaultAggregator_createVault(struct ISuperVaultAggregator.VaultCreationParams)`
- **Visibility**: public
- **Source Range**: 1729:498:651
- **Inherited From**: SuperVaultAggregatorTargets

## Implementation

```solidity
function superVaultAggregator_createVault(ISuperVaultAggregator.VaultCreationParams memory params) public asActor() {
    (address _superVault, address _strategy, address _escrow) = superVaultAggregator.createVault(params);
    superVault = SuperVault(_superVault);
    superVaultStrategy = SuperVaultStrategy(payable(_strategy));
    superVaultEscrow = SuperVaultEscrow(_escrow);
    hasDeployedNewVault = true;
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

- **UnsafeSuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTargets.superVaultAggregator_createVault(struct ISuperVaultAggregator.VaultCreationParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
