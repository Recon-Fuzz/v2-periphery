# Function: test_ChangePrimaryManager_PreventsAttackScenario()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangePrimaryManager_PreventsAttackScenario()`
- **Visibility**: public
- **Source Range**: 95752:2316:661

## Implementation

```solidity
/// @notice Tests the complete attack scenario - malicious manager cannot regain control
function test_ChangePrimaryManager_PreventsAttackScenario() public {
    address maliciousSecondary1 = _deployAccount(0x12, "MaliciousSecondary1");
    address maliciousSecondary2 = _deployAccount(0x13, "MaliciousSecondary2");
    vm.startPrank(manager);
    superVaultAggregator.addSecondaryManager(strategy, maliciousSecondary1);
    superVaultAggregator.addSecondaryManager(strategy, maliciousSecondary2);
    vm.stopPrank();
    address controlledAccount = _deployAccount(0x14, "ControlledAccount");
    vm.prank(maliciousSecondary1);
    superVaultAggregator.proposeChangePrimaryManager(strategy, controlledAccount, treasury);
    address emergencyManager = _deployAccount(0x15, "EmergencyManager");
    address feeRecipient = _deployAccount(0x2C, "FeeRecipient");
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, emergencyManager, feeRecipient);
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 0, "All malicious secondary managers should be removed");
    address currentManager = superVaultAggregator.getMainManager(strategy);
    assertEq(currentManager, emergencyManager, "Emergency manager should be in control");
    vm.prank(maliciousSecondary1);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeChangePrimaryManager(strategy, controlledAccount, treasury);
    vm.prank(maliciousSecondary2);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeChangePrimaryManager(strategy, controlledAccount, treasury);
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getSecondaryManagers(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangePrimaryManager_PreventsAttackScenario() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x12, "MaliciousSecondary1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x13, "MaliciousSecondary2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x14, "ControlledAccount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x15, "EmergencyManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x2C, "FeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [secondaryManagers.length, 0, "All malicious secondary managers should be removed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 7)
      💬 Args: [currentManager, emergencyManager, "Emergency manager should be in control"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the complete attack scenario - malicious manager cannot regain control
