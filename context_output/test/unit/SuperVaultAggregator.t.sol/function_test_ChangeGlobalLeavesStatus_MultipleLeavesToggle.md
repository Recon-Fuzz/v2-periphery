# Function: test_ChangeGlobalLeavesStatus_MultipleLeavesToggle()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_MultipleLeavesToggle()`
- **Visibility**: public
- **Source Range**: 167876:1113:661

## Implementation

```solidity
/// @notice Tests multiple leaves banning and unbanning
function test_ChangeGlobalLeavesStatus_MultipleLeavesToggle() public {
    bytes32 leaf1 = keccak256("leaf1");
    bytes32 leaf2 = keccak256("leaf2");
    bytes32 leaf3 = keccak256("leaf3");
    bytes32[] memory leaves = new bytes32[](3);
    leaves[0] = leaf1;
    leaves[1] = leaf2;
    leaves[2] = leaf3;
    bool[] memory statuses = new bool[](3);
    statuses[0] = true;
    statuses[1] = true;
    statuses[2] = true;
    vm.prank(manager);
    superVaultAggregator.changeGlobalLeavesStatus(leaves, statuses, strategy);
    bytes32[] memory singleLeaf = new bytes32[](1);
    singleLeaf[0] = leaf2;
    bool[] memory singleStatus = new bool[](1);
    singleStatus[0] = false;
    vm.prank(manager);
    vm.expectEmit(true, false, false, true);
    emit ISuperVaultAggregator.GlobalLeavesStatusChanged(strategy, singleLeaf, singleStatus);
    superVaultAggregator.changeGlobalLeavesStatus(singleLeaf, singleStatus, strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::changeGlobalLeavesStatus(bytes32[],bool[],address)**
- **Vm::expectEmit(bool,bool,bool,bool)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_MultipleLeavesToggle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests multiple leaves banning and unbanning
