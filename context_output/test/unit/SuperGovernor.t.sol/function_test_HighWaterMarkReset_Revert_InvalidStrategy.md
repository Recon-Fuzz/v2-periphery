# Function: test_HighWaterMarkReset_Revert_InvalidStrategy()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HighWaterMarkReset_Revert_InvalidStrategy()`
- **Visibility**: public
- **Source Range**: 28646:221:659

## Implementation

```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the strategy is not set
function test_HighWaterMarkReset_Revert_InvalidStrategy() public {
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.resetHighWaterMark(address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HighWaterMarkReset_Revert_InvalidStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests resetting the high-water mark PPS to the current PPS when the strategy is not set
