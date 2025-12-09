# Function: test_constructor_Revert_ZeroGuardian()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_constructor_Revert_ZeroGuardian()`
- **Visibility**: public
- **Source Range**: 9340:438:659

## Implementation

```solidity
/// @notice Tests constructor revert on zero address guardian.
function test_constructor_Revert_ZeroGuardian() public {
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, address(0), treasury, false))})));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **VmContractHelper692::deployCode(string,bytes)**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_constructor_Revert_ZeroGuardian() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests constructor revert on zero address guardian.
