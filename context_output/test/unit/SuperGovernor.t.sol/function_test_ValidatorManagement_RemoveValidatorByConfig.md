# Function: test_ValidatorManagement_RemoveValidatorByConfig()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_RemoveValidatorByConfig()`
- **Visibility**: public
- **Source Range**: 55417:1044:659

## Implementation

```solidity
/// @notice Tests removing validators by updating config
function test_ValidatorManagement_RemoveValidatorByConfig() public {
    address[] memory validators = new address[](1);
    validators[0] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    assertTrue(superGovernor.isValidator(validator1), "Validator should be added");
    address[] memory emptyValidators = new address[](1);
    emptyValidators[0] = validator2;
    bytes[] memory emptyKeys = new bytes[](1);
    emptyKeys[0] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(2, emptyValidators, emptyKeys, 1, "");
    assertFalse(superGovernor.isValidator(validator1), "Validator1 should be removed");
    assertTrue(superGovernor.isValidator(validator2), "Validator2 should be added");
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
- **SuperGovernor::isValidator(address)**

## State Variable Reads

- **validator1** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **validator2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_RemoveValidatorByConfig() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.isValidator(validator1), "Validator should be added"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.isValidator(validator1), "Validator1 should be removed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [superGovernor.isValidator(validator2), "Validator2 should be added"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests removing validators by updating config
