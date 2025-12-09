# Function: test_ChangePrimaryManager_EmitsEvents()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_EmitsEvents()`
- **Visibility**: public
- **Source Range**: 102439:1101:661

## Implementation

```solidity
/// @notice Tests that emergency replacement emits proper events
function test_ChangePrimaryManager_EmitsEvents() public {
    address secondaryManager2 = _deployAccount(0x1B, "SecondaryManager2");
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, secondaryManager2);
    address emergencyManager = _deployAccount(0x1C, "EmergencyManager");
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.SecondaryManagerRemoved(strategy, secondaryManager);
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.SecondaryManagerRemoved(strategy, secondaryManager2);
    vm.expectEmit(true, true, true, false);
    emit ISuperVaultAggregator.PrimaryManagerChanged(strategy, manager, emergencyManager, treasury);
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, emergencyManager, treasury);
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_EmitsEvents() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x1B, "SecondaryManager2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0x1C, "EmergencyManager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that emergency replacement emits proper events
