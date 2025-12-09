# Function: test_ExecuteMinUpdateIntervalChange_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 200595:1104:661

## Implementation

```solidity
/// @notice Test 2: Propose and execute change successfully
function test_ExecuteMinUpdateIntervalChange_Success() public {
    uint256 newInterval = 10;
    uint256 oldInterval = superVaultAggregator.getMinUpdateInterval(strategy);
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, newInterval);
    vm.warp((block.timestamp + 3 days) + 1);
    vm.expectEmit(true, false, false, true);
    emit MinUpdateIntervalChanged(strategy, oldInterval, newInterval);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), newInterval, "MinUpdateInterval should be updated");
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 0, "Proposal should be cleared");
    assertEq(effectiveTime, 0, "Effective time should be cleared");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::getMinUpdateInterval(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::warp(uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteMinUpdateIntervalChange_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), newInterval, "MinUpdateInterval should be updated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [proposedInterval, 0, "Proposal should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [effectiveTime, 0, "Effective time should be cleared"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 2: Propose and execute change successfully
