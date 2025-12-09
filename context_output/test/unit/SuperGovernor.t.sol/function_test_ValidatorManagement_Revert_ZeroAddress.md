# Function: test_ValidatorManagement_Revert_ZeroAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 54222:439:659

## Implementation

```solidity
/// @notice Tests reverting when setting validator config with zero address
function test_ValidatorManagement_Revert_ZeroAddress() public {
    address[] memory validators = new address[](1);
    validators[0] = address(0);
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_Revert_ZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when setting validator config with zero address
