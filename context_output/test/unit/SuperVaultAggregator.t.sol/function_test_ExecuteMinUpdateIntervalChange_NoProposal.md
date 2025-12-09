# Function: test_ExecuteMinUpdateIntervalChange_NoProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteMinUpdateIntervalChange_NoProposal()`
- **Visibility**: public
- **Source Range**: 205508:238:661

## Implementation

```solidity
/// @notice Test 8: Execute without proposal reverts
function test_ExecuteMinUpdateIntervalChange_NoProposal() public {
    vm.expectRevert(ISuperVaultAggregator.NO_PENDING_MIN_UPDATE_INTERVAL_CHANGE.selector);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteMinUpdateIntervalChange_NoProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 8: Execute without proposal reverts
