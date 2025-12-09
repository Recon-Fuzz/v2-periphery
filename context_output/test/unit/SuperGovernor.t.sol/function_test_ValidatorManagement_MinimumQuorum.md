# Function: test_ValidatorManagement_MinimumQuorum()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_MinimumQuorum()`
- **Visibility**: public
- **Source Range**: 60378:617:659

## Implementation

```solidity
/// @notice Tests edge case with quorum of 1
function test_ValidatorManagement_MinimumQuorum() public {
    address[] memory validators = new address[](3);
    validators[0] = validator1;
    validators[1] = validator2;
    validators[2] = address(0x123);
    bytes[] memory validatorPublicKeys = new bytes[](3);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    validatorPublicKeys[2] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    assertEq(superGovernor.getPPSOracleQuorum(), 1, "Quorum should be 1");
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

## State Variable Reads

- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_MinimumQuorum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superGovernor.getPPSOracleQuorum(), 1, "Quorum should be 1"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests edge case with quorum of 1
