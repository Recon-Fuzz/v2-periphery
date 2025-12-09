# Function: test_GetDeviationThreshold()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetDeviationThreshold()`
- **Visibility**: public
- **Source Range**: 56196:726:661

## Implementation

```solidity
/// @notice Tests that getDeviationThreshold returns the correct deviation threshold
function test_GetDeviationThreshold() public {
    uint256 threshold = superVaultAggregator.getDeviationThreshold(strategy);
    assertEq(threshold, 5e17, "Default deviation threshold should be 50% (5e17)");
    uint256 newThreshold = 1e17;
    vm.prank(manager);
    superVaultAggregator.updateDeviationThreshold(strategy, newThreshold);
    uint256 updatedThreshold = superVaultAggregator.getDeviationThreshold(strategy);
    assertEq(updatedThreshold, newThreshold, "Updated deviation threshold should be returned");
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

- **SuperVaultAggregator::getDeviationThreshold(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetDeviationThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [threshold, 5e17, "Default deviation threshold should be 50% (5e17)"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [updatedThreshold, newThreshold, "Updated deviation threshold should be returned"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that getDeviationThreshold returns the correct deviation threshold
