# Function: test_ChangePrimaryManager_ClearsSecondaryManagers()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_ClearsSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 73474:1777:661

## Implementation

```solidity
/// @notice Tests emergency replacement clears all secondary managers
function test_ChangePrimaryManager_ClearsSecondaryManagers() public {
    address secondaryManager2 = _deployAccount(0xE, "SecondaryManager2");
    address secondaryManager3 = _deployAccount(0xF, "SecondaryManager3");
    vm.startPrank(manager);
    superVaultAggregator.addSecondaryManager(strategy, secondaryManager2);
    superVaultAggregator.addSecondaryManager(strategy, secondaryManager3);
    vm.stopPrank();
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 3, "Should have 3 secondary managers");
    address emergencyManager = _deployAccount(0x10, "EmergencyManager");
    address feeRecipient = _deployAccount(0x28, "FeeRecipient");
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.SecondaryManagerRemoved(strategy, secondaryManager);
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.SecondaryManagerRemoved(strategy, secondaryManager2);
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.SecondaryManagerRemoved(strategy, secondaryManager3);
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, emergencyManager, feeRecipient);
    secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 0, "All secondary managers should be cleared");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::getSecondaryManagers(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **Vm::prank(address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_ClearsSecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xE, "SecondaryManager2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0xF, "SecondaryManager3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [secondaryManagers.length, 3, "Should have 3 secondary managers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x10, "EmergencyManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x28, "FeeRecipient"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [secondaryManagers.length, 0, "All secondary managers should be cleared"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests emergency replacement clears all secondary managers
