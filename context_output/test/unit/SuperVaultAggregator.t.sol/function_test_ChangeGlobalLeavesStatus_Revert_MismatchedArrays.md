# Function: test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays()`
- **Visibility**: public
- **Source Range**: 157705:502:661

## Implementation

```solidity
/// @notice Tests that mismatched array lengths revert
function test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays() public {
    bytes32[] memory leaves = new bytes32[](2);
    leaves[0] = keccak256("leaf1");
    leaves[1] = keccak256("leaf2");
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MISMATCHED_ARRAY_LENGTHS.selector);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that mismatched array lengths revert
