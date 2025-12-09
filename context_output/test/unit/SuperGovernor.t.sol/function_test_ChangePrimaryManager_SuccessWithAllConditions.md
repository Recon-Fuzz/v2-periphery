# Function: test_ChangePrimaryManager_SuccessWithAllConditions()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangePrimaryManager_SuccessWithAllConditions()`
- **Visibility**: public
- **Source Range**: 25662:1192:659

## Implementation

```solidity
/// @notice Tests changePrimaryManager success path with all checks passing
///  @dev Comprehensive test covering all conditions: not frozen, aggregator set, authorized caller
function test_ChangePrimaryManager_SuccessWithAllConditions() public {
    address initialManager = ISuperVaultAggregator(superVaultAggregator).getMainManager(strategy1);
    assertEq(initialManager, address(this), "Initial manager should be this contract");
    address feeRecipient = _deployAccount(0x2E, "FeeRecipient");
    assertFalse(superGovernor.isManagerTakeoverFrozen(), "Manager takeovers should not be frozen initially");
    vm.prank(sGovernor);
    superGovernor.changePrimaryManager(strategy1, newManager, feeRecipient);
    address updatedManager = ISuperVaultAggregator(superVaultAggregator).getMainManager(strategy1);
    assertEq(updatedManager, newManager, "Manager should be updated to newManager");
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy(strategy1).getConfigInfo();
    assertEq(feeConfig.recipient, feeRecipient, "Fee recipient should be updated");
}
```

## Related Implementations

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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **ISuperVaultAggregator::getMainManager(address)**
- **SuperGovernor::isManagerTakeoverFrozen()**
- **Vm::prank(address)**
- **SuperGovernor::changePrimaryManager(address,address,address)**
- **ISuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **superVaultAggregator** (`address`)
- **strategy1** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **newManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangePrimaryManager_SuccessWithAllConditions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [initialManager, address(this), "Initial manager should be this contract"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x2E, "FeeRecipient"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.isManagerTakeoverFrozen(), "Manager takeovers should not be frozen initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [updatedManager, newManager, "Manager should be updated to newManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 5)
      💬 Args: [feeConfig.recipient, feeRecipient, "Fee recipient should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests changePrimaryManager success path with all checks passing
 @dev Comprehensive test covering all conditions: not frozen, aggregator set, authorized caller
