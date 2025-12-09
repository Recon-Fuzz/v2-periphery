# Function: test_ValidatorManagement_Revert_DuplicateValidators()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_Revert_DuplicateValidators()`
- **Visibility**: public
- **Source Range**: 54742:608:659

## Implementation

```solidity
/// @notice Tests reverting when adding duplicate validators in config
function test_ValidatorManagement_Revert_DuplicateValidators() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.VALIDATOR_ALREADY_REGISTERED.selector);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 2, "");
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**

## State Variable Reads

- **validator1** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_Revert_DuplicateValidators() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when adding duplicate validators in config
