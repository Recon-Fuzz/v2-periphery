# Function: test_ValidatorManagement_UpdateConfigWithMultiple()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_UpdateConfigWithMultiple()`
- **Visibility**: public
- **Source Range**: 56540:1305:659

## Implementation

```solidity
/// @notice Tests updating validator config with multiple validators
function test_ValidatorManagement_UpdateConfigWithMultiple() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    vm.startPrank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 2, "");
    vm.stopPrank();
    address[] memory newValidators = new address[](1);
    newValidators[0] = validator2;
    bytes[] memory newKeys = new bytes[](1);
    newKeys[0] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(2, newValidators, newKeys, 1, "");
    assertFalse(superGovernor.isValidator(validator1), "validator1 should be removed");
    assertTrue(superGovernor.isValidator(validator2), "validator2 should still be registered");
    address[] memory validatorsList = superGovernor.getValidators();
    assertEq(validatorsList.length, 1, "Should have 1 validator remaining");
    assertEq(validatorsList[0], validator2, "Remaining validator should be validator2");
}
```

## Related Implementations

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

- **Vm::startPrank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperGovernor::isValidator(address)**
- **SuperGovernor::getValidators()**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_UpdateConfigWithMultiple() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isValidator(validator1), "validator1 should be removed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isValidator(validator2), "validator2 should still be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [validatorsList.length, 1, "Should have 1 validator remaining"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [validatorsList[0], validator2, "Remaining validator should be validator2"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests updating validator config with multiple validators
