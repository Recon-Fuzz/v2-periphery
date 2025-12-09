# Function: test_PPSOracleManagement_Revert_SetActiveZeroAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_PPSOracleManagement_Revert_SetActiveZeroAddress()`
- **Visibility**: public
- **Source Range**: 69216:227:659

## Implementation

```solidity
/// @notice Tests reverting when setting active PPS Oracle with zero address
///  @dev Covers SuperGovernor.sol:427 - if (oracle == address(0)) revert INVALID_ADDRESS()
function test_PPSOracleManagement_Revert_SetActiveZeroAddress() public {
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setActivePPSOracle(address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setActivePPSOracle(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_PPSOracleManagement_Revert_SetActiveZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when setting active PPS Oracle with zero address
 @dev Covers SuperGovernor.sol:427 - if (oracle == address(0)) revert INVALID_ADDRESS()
