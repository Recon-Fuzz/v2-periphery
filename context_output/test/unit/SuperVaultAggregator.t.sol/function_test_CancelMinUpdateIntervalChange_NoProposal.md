# Function: test_CancelMinUpdateIntervalChange_NoProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelMinUpdateIntervalChange_NoProposal()`
- **Visibility**: public
- **Source Range**: 216305:312:661

## Implementation

```solidity
/// @notice Test 18: Cannot cancel if no proposal exists
function test_CancelMinUpdateIntervalChange_NoProposal() public {
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE.selector);
    vm.prank(manager);
    superVaultAggregator.cancelMinUpdateIntervalChange(strategy);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **Vm::prank(address)**
- **SuperVaultAggregator::cancelMinUpdateIntervalChange(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelMinUpdateIntervalChange_NoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 18: Cannot cancel if no proposal exists
