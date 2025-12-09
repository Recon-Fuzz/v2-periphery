# Function: test_ChangeGlobalLeavesStatus_EmptyArrays()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 171577:417:661

## Implementation

```solidity
/// @notice Tests empty arrays are handled correctly
function test_ChangeGlobalLeavesStatus_EmptyArrays() public {
    bytes32[] memory leaves = new bytes32[](0);
    bool[] memory statuses = new bool[](0);
    vm.prank(manager);
    vm.expectEmit(true, false, false, true);
    emit ISuperVaultAggregator.GlobalLeavesStatusChanged(strategy, leaves, statuses);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_EmptyArrays() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests empty arrays are handled correctly
