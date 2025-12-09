# Function: test_PPSOracleManagement_Revert_ProposeZeroAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_PPSOracleManagement_Revert_ProposeZeroAddress()`
- **Visibility**: public
- **Source Range**: 68805:229:659

## Implementation

```solidity
/// @notice Tests reverting when proposing a PPS Oracle with zero address
function test_PPSOracleManagement_Revert_ProposeZeroAddress() public {
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.proposeActivePPSOracle(address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::proposeActivePPSOracle(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_PPSOracleManagement_Revert_ProposeZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when proposing a PPS Oracle with zero address
