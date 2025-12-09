# Function: test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller()`
- **Visibility**: public
- **Source Range**: 156861:779:661

## Implementation

```solidity
/// @notice Tests that only primary manager can change global leaves status
function test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller() public {
    bytes32[] memory leaves = new bytes32[](1);
    leaves[0] = keccak256("test_leaf");
    bool[] memory statuses = new bool[](1);
    statuses[0] = true;
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that only primary manager can change global leaves status
