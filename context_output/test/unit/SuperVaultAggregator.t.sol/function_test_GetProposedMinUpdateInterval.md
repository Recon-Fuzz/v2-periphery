# Function: test_GetProposedMinUpdateInterval()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetProposedMinUpdateInterval()`
- **Visibility**: public
- **Source Range**: 201762:810:661

## Implementation

```solidity
/// @notice Test 3: Get proposed min update interval
function test_GetProposedMinUpdateInterval() public {
    (uint256 proposedInterval, uint256 effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 0, "Should return 0 with no proposal");
    assertEq(effectiveTime, 0, "Should return 0 with no proposal");
    uint256 newInterval = 15;
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, newInterval);
    (proposedInterval, effectiveTime) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, newInterval, "Should return proposed interval");
    assertGt(effectiveTime, 0, "Should return non-zero effective time");
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

- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetProposedMinUpdateInterval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, 0, "Should return 0 with no proposal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [effectiveTime, 0, "Should return 0 with no proposal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [proposedInterval, newInterval, "Should return proposed interval"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
      💬 Args: [effectiveTime, 0, "Should return non-zero effective time"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 3: Get proposed min update interval
