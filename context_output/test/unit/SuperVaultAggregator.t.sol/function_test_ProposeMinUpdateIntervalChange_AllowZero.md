# Function: test_ProposeMinUpdateIntervalChange_AllowZero()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_AllowZero()`
- **Visibility**: public
- **Source Range**: 206484:401:661

## Implementation

```solidity
/// @notice Test 10: Allow zero as new interval
function test_ProposeMinUpdateIntervalChange_AllowZero() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 0);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 0, "Zero interval should be allowed");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_AllowZero() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 0, "Zero interval should be allowed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 10: Allow zero as new interval
