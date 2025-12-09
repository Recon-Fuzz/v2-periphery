# Function: test_ValidatorManagement_VersionTracking()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_VersionTracking()`
- **Visibility**: public
- **Source Range**: 61071:822:659

## Implementation

```solidity
/// @notice Tests version tracking across multiple config updates
function test_ValidatorManagement_VersionTracking() public {
    address[] memory validators = new address[](1);
    validators[0] = validator1;
    bytes[] memory validatorPublicKeys = new bytes[](1);
    validatorPublicKeys[0] = "";
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    (uint256 version1, , , ) = superGovernor.getValidatorConfig();
    assertEq(version1, 1, "Version should be 1");
    validators[0] = validator2;
    vm.prank(governor);
    superGovernor.setValidatorConfig(5, validators, validatorPublicKeys, 1, "");
    (uint256 version2, , , ) = superGovernor.getValidatorConfig();
    assertEq(version2, 5, "Version should be 5");
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
- **SuperGovernor::getValidatorConfig()**

## State Variable Reads

- **validator1** (`address`)
- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **validator2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_VersionTracking() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [version1, 1, "Version should be 1"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [version2, 5, "Version should be 5"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests version tracking across multiple config updates
