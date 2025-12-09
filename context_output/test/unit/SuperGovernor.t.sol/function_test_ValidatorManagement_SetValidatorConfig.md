# Function: test_ValidatorManagement_SetValidatorConfig()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_SetValidatorConfig()`
- **Visibility**: public
- **Source Range**: 51414:863:659

## Implementation

```solidity
/// @notice Tests setting validator configuration
function test_ValidatorManagement_SetValidatorConfig() public {
    address[] memory validators = new address[](1);
    validators[0] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(governor);
    vm.expectEmit(true, false, false, true);
    emit ISuperGovernor.ValidatorConfigSet(1, validators, validatorPublicKeys, 1, "");
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    assertTrue(superGovernor.isValidator(validator1), "Validator should be added");
    address[] memory validatorsList = superGovernor.getValidators();
    assertEq(validatorsList.length, 1, "Should have 1 validator");
    assertEq(validatorsList[0], validator1, "Validator in list should match");
}
```

## Related Implementations

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

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **SuperGovernor::isValidator(address)**
- **SuperGovernor::getValidators()**

## State Variable Reads

- **validator1** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_SetValidatorConfig() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isValidator(validator1), "Validator should be added"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [validatorsList.length, 1, "Should have 1 validator"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
      💬 Args: [validatorsList[0], validator1, "Validator in list should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setting validator configuration
