# Function: test_ResetHighWaterMark_EmitsEvent()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ResetHighWaterMark_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 222080:379:660

## Implementation

```solidity
/// @notice Tests resetHighWaterMark event emission
function test_ResetHighWaterMark_EmitsEvent() public {
    uint256 currentPPS = strategy.getStoredPPS();
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultStrategy.HighWaterMarkReset(currentPPS);
    vm.prank(sGovernor);
    superGovernor.resetHighWaterMark(address(strategy));
}
```

## External Calls

- **SuperVaultStrategy::getStoredPPS()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **Vm::prank(address)**
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ResetHighWaterMark_EmitsEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests resetHighWaterMark event emission
