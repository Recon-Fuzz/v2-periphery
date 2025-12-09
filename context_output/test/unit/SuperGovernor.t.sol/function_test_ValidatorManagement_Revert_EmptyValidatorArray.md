# Function: test_ValidatorManagement_Revert_EmptyValidatorArray()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_Revert_EmptyValidatorArray()`
- **Visibility**: public
- **Source Range**: 57924:370:659

## Implementation

```solidity
/// @notice Tests reverting when trying to set empty validator array
function test_ValidatorManagement_Revert_EmptyValidatorArray() public {
    address[] memory emptyValidators = new address[](0);
    bytes[] memory emptyKeys = new bytes[](0);
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.EMPTY_VALIDATOR_ARRAY.selector);
    superGovernor.setValidatorConfig(1, emptyValidators, emptyKeys, 0, "");
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_Revert_EmptyValidatorArray() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when trying to set empty validator array
