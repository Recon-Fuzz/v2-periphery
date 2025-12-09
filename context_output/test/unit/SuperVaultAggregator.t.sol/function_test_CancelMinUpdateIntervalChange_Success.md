# Function: test_CancelMinUpdateIntervalChange_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 214550:1188:661

## Implementation

```solidity
/// @notice Test 16: Cancel minUpdateInterval change proposal
function test_CancelMinUpdateIntervalChange_Success() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 100);
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 100, "Proposal should exist");
    assertGt(effectiveTime, 0, "Effective time should be set");
    vm.expectEmit(true, false, false, true);
    emit MinUpdateIntervalChangeCancelled(strategy, 100);
    vm.prank(manager);
    superVaultAggregator.cancelMinUpdateIntervalChange(strategy);
    (proposedInterval, effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 0, "Proposal should be cleared");
    assertEq(effectiveTime, 0, "Effective time should be cleared");
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 5, "MinUpdateInterval should remain unchanged");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::cancelMinUpdateIntervalChange(address)**
- **SuperVaultAggregator::getMinUpdateInterval(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelMinUpdateIntervalChange_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, 100, "Proposal should exist"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime, 0, "Effective time should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [proposedInterval, 0, "Proposal should be cleared"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [effectiveTime, 0, "Effective time should be cleared"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 5, "MinUpdateInterval should remain unchanged"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 16: Cancel minUpdateInterval change proposal
