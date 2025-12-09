# Function: test_ValidatorManagement_LargeValidatorSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_LargeValidatorSet()`
- **Visibility**: public
- **Source Range**: 65429:1066:659

## Implementation

```solidity
/// @notice Tests setting validator config with a large validator set
function test_ValidatorManagement_LargeValidatorSet() public {
    uint256 validatorCount = 50;
    address[] memory validators = new address[](validatorCount);
    bytes[] memory validatorPublicKeys = new bytes[](validatorCount);
    for (uint256 i = 0; i < validatorCount; i++) {
        validators[i] = address(uint160(1000 + i));
        validatorPublicKeys[i] = "";
    }
    vm.prank(governor);
    superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 25, "");
    assertEq(superGovernor.getValidatorsCount(), validatorCount, "Should have 50 validators");
    assertEq(superGovernor.getPPSOracleQuorum(), 25, "Quorum should be 25");
    assertTrue(superGovernor.isValidator(validators[0]), "First validator should be registered");
    assertTrue(superGovernor.isValidator(validators[25]), "Middle validator should be registered");
    assertTrue(superGovernor.isValidator(validators[49]), "Last validator should be registered");
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **SuperGovernor::getValidatorsCount()**
- **SuperGovernor::getPPSOracleQuorum()**
- **SuperGovernor::isValidator(address)**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_LargeValidatorSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getValidatorsCount(), validatorCount, "Should have 50 validators"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superGovernor.getPPSOracleQuorum(), 25, "Quorum should be 25"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [superGovernor.isValidator(validators[0]), "First validator should be registered"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [superGovernor.isValidator(validators[25]), "Middle validator should be registered"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
      💬 Args: [superGovernor.isValidator(validators[49]), "Last validator should be registered"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setting validator config with a large validator set
