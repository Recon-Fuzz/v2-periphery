# Function: test_ValidatorManagement_QuorumEqualsValidators()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_QuorumEqualsValidators()`
- **Visibility**: public
- **Source Range**: 59589:734:659

## Implementation

```solidity
/// @notice Tests edge case where quorum equals validator count
function test_ValidatorManagement_QuorumEqualsValidators() public {
    address[] memory validators = new address[](3);
    validators[0] = validator1;
    validators[1] = validator2;
    validators[2] = address(0x123);
    bytes[] memory validatorPublicKeys = new bytes[](3);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    validatorPublicKeys[2] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 3, "");
    assertEq(superGovernor.getPPSOracleQuorum(), 3, "Quorum should equal validator count");
    assertEq(superGovernor.getValidatorsCount(), 3, "Should have 3 validators");
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **SuperGovernor::getPPSOracleQuorum()**
- **SuperGovernor::getValidatorsCount()**

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_QuorumEqualsValidators() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getPPSOracleQuorum(), 3, "Quorum should equal validator count"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [superGovernor.getValidatorsCount(), 3, "Should have 3 validators"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests edge case where quorum equals validator count
