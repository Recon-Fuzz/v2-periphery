# Function: test_ChangePrimaryManager_ClearsSecondaryManagers()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ChangePrimaryManager_ClearsSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 220651:1367:660

## Implementation

```solidity
/// @notice Tests that changePrimaryManager clears all secondary managers
function test_ChangePrimaryManager_ClearsSecondaryManagers() public {
    address newManager = _deployAccount(0x111, "NewManager");
    address newFeeRecipient = _deployAccount(0x222, "NewFeeRecipient");
    address secondaryManager1 = _deployAccount(0x333, "SecondaryManager1");
    address secondaryManager2 = _deployAccount(0x444, "SecondaryManager2");
    vm.startPrank(manager);
    superVaultAggregator.addSecondaryManager(address(strategy), secondaryManager1);
    superVaultAggregator.addSecondaryManager(address(strategy), secondaryManager2);
    vm.stopPrank();
    address[] memory secondaryManagersBefore = superVaultAggregator.getSecondaryManagers(address(strategy));
    assertEq(secondaryManagersBefore.length, 2, "Should have 2 secondary managers");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(address(strategy), newManager, newFeeRecipient);
    address[] memory secondaryManagersAfter = superVaultAggregator.getSecondaryManagers(address(strategy));
    assertEq(secondaryManagersAfter.length, 0, "Secondary managers should be cleared after governance override");
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
- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ChangePrimaryManager_ClearsSecondaryManagers() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x111, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x222, "NewFeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x333, "SecondaryManager1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x444, "SecondaryManager2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [secondaryManagersBefore.length, 2, "Should have 2 secondary managers"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [secondaryManagersAfter.length, 0, "Secondary managers should be cleared after governance override"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that changePrimaryManager clears all secondary managers
