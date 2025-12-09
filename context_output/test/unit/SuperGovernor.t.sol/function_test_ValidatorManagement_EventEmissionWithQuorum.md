# Function: test_ValidatorManagement_EventEmissionWithQuorum()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_EventEmissionWithQuorum()`
- **Visibility**: public
- **Source Range**: 66585:966:659

## Implementation

```solidity
/// @notice Tests that ValidatorConfigSet event is emitted with quorum included
function test_ValidatorManagement_EventEmissionWithQuorum() public {
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory validatorPublicKeys = new bytes[](2);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    uint256 quorum = 2;
    uint256 version = 1;
    vm.prank(governor);
    vm.expectEmit(true, false, false, true);
    emit ISuperGovernor.ValidatorConfigSet(version, validators, validatorPublicKeys, quorum, "");
    superGovernor.setValidatorConfig(version, validators, validatorPublicKeys, quorum, "");
    assertEq(superGovernor.getPPSOracleQuorum(), quorum, "Quorum should be updated");
    assertEq(superGovernor.getValidatorsCount(), 2, "Should have 2 validators");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_EventEmissionWithQuorum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superGovernor.getPPSOracleQuorum(), quorum, "Quorum should be updated"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [superGovernor.getValidatorsCount(), 2, "Should have 2 validators"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that ValidatorConfigSet event is emitted with quorum included
