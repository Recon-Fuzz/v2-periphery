# Function: test_ValidatorManagement_Revert_ArrayLengthMismatch()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_Revert_ArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 58385:509:659

## Implementation

```solidity
/// @notice Tests reverting when validator and public key array lengths mismatch
function test_ValidatorManagement_Revert_ArrayLengthMismatch() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.ARRAY_LENGTH_MISMATCH.selector);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_Revert_ArrayLengthMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when validator and public key array lengths mismatch
