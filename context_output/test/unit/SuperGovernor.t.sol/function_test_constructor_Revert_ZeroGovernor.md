# Function: test_constructor_Revert_ZeroGovernor()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_constructor_Revert_ZeroGovernor()`
- **Visibility**: public
- **Source Range**: 7802:438:659

## Implementation

```solidity
/// @notice Tests constructor revert on zero address governor.
function test_constructor_Revert_ZeroGovernor() public {
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, address(0), governor, oracleManager, governor, guardian, treasury, false))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper692::deployCode(string,bytes)**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **guardian** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_constructor_Revert_ZeroGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests constructor revert on zero address governor.
