# Function: test_MinUpdateIntervalChange_MultipleCycles()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_MinUpdateIntervalChange_MultipleCycles()`
- **Visibility**: public
- **Source Range**: 202638:1118:661

## Implementation

```solidity
/// @notice Test 4: Multiple propose and execute cycles
function test_MinUpdateIntervalChange_MultipleCycles() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 10, "First change should succeed");
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 20);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 20, "Second change should succeed");
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 0);
    vm.warp((block.timestamp + 3 days) + 1);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    assertEq(superVaultAggregator.getMinUpdateInterval(strategy), 0, "Third change should succeed");
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_MinUpdateIntervalChange_MultipleCycles() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 10, "First change should succeed"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 20, "Second change should succeed"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [superVaultAggregator.getMinUpdateInterval(strategy), 0, "Third change should succeed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test 4: Multiple propose and execute cycles
