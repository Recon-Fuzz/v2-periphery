# Function: test_ProposeMinUpdateIntervalChange_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 199780:745:661

## Implementation

```solidity
/// @notice Test 1: Main manager proposes valid change
function test_ProposeMinUpdateIntervalChange_Success() public {
    uint256 newInterval = 10;
    uint256 expectedEffectiveTime = block.timestamp + 3 days;
    vm.expectEmit(true, true, false, true);
    emit MinUpdateIntervalChangeProposed(strategy, manager, newInterval, expectedEffectiveTime);
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, newInterval);
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, newInterval, "Proposed interval should match");
    assertEq(effectiveTime, expectedEffectiveTime, "Effective time should be block.timestamp + 3 days");
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

- **Vm::expectEmit(bool,bool,bool,bool)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**

## State Variable Reads

- **strategy** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, newInterval, "Proposed interval should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, expectedEffectiveTime, "Effective time should be block.timestamp + 3 days"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 1: Main manager proposes valid change
