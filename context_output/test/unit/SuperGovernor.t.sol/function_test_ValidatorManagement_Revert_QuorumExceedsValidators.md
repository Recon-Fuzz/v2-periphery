# Function: test_ValidatorManagement_Revert_QuorumExceedsValidators()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_Revert_QuorumExceedsValidators()`
- **Visibility**: public
- **Source Range**: 58968:547:659

## Implementation

```solidity
/// @notice Tests reverting when quorum exceeds validator count
function test_ValidatorManagement_Revert_QuorumExceedsValidators() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_QUORUM.selector);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 3, "");
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_Revert_QuorumExceedsValidators() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when quorum exceeds validator count
