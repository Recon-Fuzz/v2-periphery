# Function: test_ValidatorManagement_GetValidatorAt()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_GetValidatorAt()`
- **Visibility**: public
- **Source Range**: 52354:1782:659

## Implementation

```solidity
/// @notice Tests getting validators by index using getValidatorAt
function test_ValidatorManagement_GetValidatorAt() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 2, "");
    vm.stopPrank();
    uint256 count = superGovernor.getValidatorsCount();
    assertEq(count, 2, "Should have 2 validators");
    address validatorAt0 = superGovernor.getValidatorAt(0);
    address validatorAt1 = superGovernor.getValidatorAt(1);
    assertTrue((validatorAt0 == validator1) || (validatorAt0 == validator2), "Index 0 should be validator1 or validator2");
    assertTrue((validatorAt1 == validator1) || (validatorAt1 == validator2), "Index 1 should be validator1 or validator2");
    assertTrue(validatorAt0 != validatorAt1, "Validators at different indices should be different");
    assertTrue(superGovernor.isValidator(validatorAt0), "Validator at index 0 should be registered");
    assertTrue(superGovernor.isValidator(validatorAt1), "Validator at index 1 should be registered");
    vm.expectRevert();
    superGovernor.getValidatorAt(2);
    vm.expectRevert();
    superGovernor.getValidatorAt(999);
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **Vm::stopPrank()**
- **SuperGovernor::getValidatorsCount()**
- **SuperGovernor::getValidatorAt(uint256)**
- **SuperGovernor::isValidator(address)**
- **Vm::expectRevert()**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_GetValidatorAt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [count, 2, "Should have 2 validators"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [(validatorAt0 == validator1) || (validatorAt0 == validator2), "Index 0 should be validator1 or validator2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [(validatorAt1 == validator1) || (validatorAt1 == validator2), "Index 1 should be validator1 or validator2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [validatorAt0 != validatorAt1, "Validators at different indices should be different"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [superGovernor.isValidator(validatorAt0), "Validator at index 0 should be registered"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 6)
      💬 Args: [superGovernor.isValidator(validatorAt1), "Validator at index 1 should be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getting validators by index using getValidatorAt
