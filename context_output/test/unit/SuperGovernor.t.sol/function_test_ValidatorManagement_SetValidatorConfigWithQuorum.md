# Function: test_ValidatorManagement_SetValidatorConfigWithQuorum()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ValidatorManagement_SetValidatorConfigWithQuorum()`
- **Visibility**: public
- **Source Range**: 71229:1233:659

## Implementation

```solidity
/// @notice Tests setting the validator configuration including quorum
function test_ValidatorManagement_SetValidatorConfigWithQuorum() public {
    address[] memory validators = new address[](3);
    validators[0] = address(0x1);
    validators[1] = address(0x2);
    validators[2] = address(0x3);
    bytes[] memory validatorPublicKeys = new bytes[](3);
    validatorPublicKeys[0] = "";
    validatorPublicKeys[1] = "";
    validatorPublicKeys[2] = "";
    uint256 newQuorum = 2;
    uint256 version = 1;
    vm.prank(governor);
    vm.expectRevert(ISuperGovernor.INVALID_QUORUM.selector);
    superGovernor.setValidatorConfig(version, validators, validatorPublicKeys, 0, "");
    vm.prank(governor);
    vm.expectEmit(true, false, false, true);
    emit ISuperGovernor.ValidatorConfigSet(version, validators, validatorPublicKeys, newQuorum, "");
    superGovernor.setValidatorConfig(version, validators, validatorPublicKeys, newQuorum, "");
    assertEq(superGovernor.getPPSOracleQuorum(), newQuorum, "PPS Oracle quorum mismatch");
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
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setValidatorConfig(uint256,address[],bytes[],uint256,bytes)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::getPPSOracleQuorum()**

## State Variable Reads

- **governor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ValidatorManagement_SetValidatorConfigWithQuorum() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superGovernor.getPPSOracleQuorum(), newQuorum, "PPS Oracle quorum mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setting the validator configuration including quorum
