# Function: test_Role_GovernorOnlyFunctions()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_Role_GovernorOnlyFunctions()`
- **Visibility**: public
- **Source Range**: 13774:797:659

## Implementation

```solidity
/// @notice Tests that only GOVERNOR_ROLE can call GOVERNOR_ROLE functions.
function test_Role_GovernorOnlyFunctions() public {
    address[] memory validators = new address[](1);
    validators[0] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(sGovernor);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, sGovernor, GOVERNOR_ROLE));
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**

## State Variable Reads

- **validator1** (`address`)
- **sGovernor** (`address`)
- **GOVERNOR_ROLE** (`bytes32`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_Role_GovernorOnlyFunctions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that only GOVERNOR_ROLE can call GOVERNOR_ROLE functions.
