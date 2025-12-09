# Function: test_ProposeMinUpdateIntervalChange_OverwritePendingProposal()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_OverwritePendingProposal()`
- **Visibility**: public
- **Source Range**: 206957:985:661

## Implementation

```solidity
/// @notice Test 11: New proposal overwrites pending proposal
function test_ProposeMinUpdateIntervalChange_OverwritePendingProposal() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
    (uint256 proposedInterval, ) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 10, "First proposal should be stored");
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 20);
    (proposedInterval, ) = superVaultAggregator.getProposedMinUpdateInterval(strategy);
    assertEq(proposedInterval, 20, "Second proposal should overwrite first");
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 20, "Should apply second proposal");
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

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **SuperVaultAggregator::getProposedMinUpdateInterval(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**
- **SuperVaultAggregator::getMinUpdateInterval(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_OverwritePendingProposal() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [proposedInterval, 10, "First proposal should be stored"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [proposedInterval, 20, "Second proposal should overwrite first"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 20, "Should apply second proposal"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 11: New proposal overwrites pending proposal
