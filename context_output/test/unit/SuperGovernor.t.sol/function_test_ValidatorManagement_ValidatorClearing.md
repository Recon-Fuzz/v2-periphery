# Function: test_ValidatorManagement_ValidatorClearing()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_ValidatorClearing()`
- **Visibility**: public
- **Source Range**: 63628:1721:659

## Implementation

```solidity
/// @notice Tests that old validators are properly cleared when setting new config
function test_ValidatorManagement_ValidatorClearing() public {
    address[] memory validators1 = new address[](3);
    validators1[0] = validator1;
    validators1[1] = validator2;
    validators1[2] = address(0x123);
    bytes[] memory validatorPublicKeys1 = new bytes[](3);
    validatorPublicKeys1[0] = "";
    validatorPublicKeys1[1] = "";
    validatorPublicKeys1[2] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators1, validatorPublicKeys1, 2, "");
    assertEq(superGovernor.getValidatorsCount(), 3, "Should have 3 validators");
    assertTrue(superGovernor.isValidator(validator1), "validator1 should be registered");
    assertTrue(superGovernor.isValidator(validator2), "validator2 should be registered");
    address[] memory validators2 = new address[](1);
    validators2[0] = address(0x456);
    bytes[] memory validatorPublicKeys2 = new bytes[](1);
    validatorPublicKeys2[0] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(2, validators2, validatorPublicKeys2, 1, "");
    assertEq(superGovernor.getValidatorsCount(), 1, "Should have 1 validator");
    assertFalse(superGovernor.isValidator(validator1), "validator1 should be cleared");
    assertFalse(superGovernor.isValidator(validator2), "validator2 should be cleared");
    assertFalse(superGovernor.isValidator(address(0x123)), "validator3 should be cleared");
    assertTrue(superGovernor.isValidator(address(0x456)), "New validator should be registered");
}
```

## Related Implementations

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

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
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

- **Vm::prank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **SuperGovernor::getValidatorsCount()**
- **SuperGovernor::isValidator(address)**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_ValidatorClearing() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getValidatorsCount(), 3, "Should have 3 validators"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isValidator(validator1), "validator1 should be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.isValidator(validator2), "validator2 should be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [superGovernor.getValidatorsCount(), 1, "Should have 1 validator"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 5)
  │   💬 Args: [superGovernor.isValidator(validator1), "validator1 should be cleared"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 6)
  │   💬 Args: [superGovernor.isValidator(validator2), "validator2 should be cleared"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 7)
  │   💬 Args: [superGovernor.isValidator(address(0x123)), "validator3 should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 8)
      💬 Args: [superGovernor.isValidator(address(0x456)), "New validator should be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that old validators are properly cleared when setting new config
