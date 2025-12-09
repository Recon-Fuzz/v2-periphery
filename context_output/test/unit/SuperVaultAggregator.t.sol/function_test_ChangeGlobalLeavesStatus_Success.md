# Function: test_ChangeGlobalLeavesStatus_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ChangeGlobalLeavesStatus_Success()`
- **Visibility**: public
- **Source Range**: 155939:836:661

## Implementation

```solidity
/// @notice Tests successfully changing global leaves status
function test_ChangeGlobalLeavesStatus_Success() public {
    bytes32 leaf1 = keccak256(bytes.concat(keccak256(abi.encode(address(0x123), "args1"))));
    bytes32 leaf2 = keccak256(bytes.concat(keccak256(abi.encode(address(0x456), "args2"))));
    bytes32[] memory leaves = new bytes32[](2);
    leaves[0] = leaf1;
    leaves[1] = leaf2;
    bool[] memory statuses = new bool[](2);
    statuses[0] = true;
    statuses[1] = false;
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ChangeGlobalLeavesStatus_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests successfully changing global leaves status
