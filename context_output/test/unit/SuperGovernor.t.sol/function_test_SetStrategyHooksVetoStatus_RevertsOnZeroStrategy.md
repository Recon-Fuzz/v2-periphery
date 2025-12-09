# Function: test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy()`
- **Visibility**: public
- **Source Range**: 42983:245:659

## Implementation

```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when strategy is zero address
///  @dev Covers SuperGovernor.sol:237 - if (strategy == address(0)) revert INVALID_ADDRESS()
function test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy() public {
    vm.prank(guardian);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setStrategyHooksRootVetoStatus(address(0), true);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setStrategyHooksRootVetoStatus(address,bool)**

## State Variable Reads

- **guardian** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests setStrategyHooksRootVetoStatus reverts when strategy is zero address
 @dev Covers SuperGovernor.sol:237 - if (strategy == address(0)) revert INVALID_ADDRESS()
