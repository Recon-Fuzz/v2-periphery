# Function: test_GetStrategyHooksRoot()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GetStrategyHooksRoot()`
- **Visibility**: public
- **Source Range**: 71287:1116:661

## Implementation

```solidity
/// @notice Tests getStrategyHooksRoot returns strategy-specific hooks root
function test_GetStrategyHooksRoot() public {
    bytes32 strategyRoot = superVaultAggregator.getStrategyHooksRoot(strategy);
    assertEq(strategyRoot, bytes32(0), "Initial strategy hooks root should be zero");
    bytes32 newRoot = keccak256("strategyRoot");
    vm.prank(manager);
    superVaultAggregator.proposeStrategyHooksRoot(strategy, newRoot);
    strategyRoot = superVaultAggregator.getStrategyHooksRoot(strategy);
    assertEq(strategyRoot, bytes32(0), "Root should still be zero before execution");
    uint256 timelock = superVaultAggregator.getHooksRootUpdateTimelock();
    vm.warp(block.timestamp + timelock);
    superVaultAggregator.executeStrategyHooksRootUpdate(strategy);
    strategyRoot = superVaultAggregator.getStrategyHooksRoot(strategy);
    assertEq(strategyRoot, newRoot, "Strategy hooks root should be updated");
}
```

## Related Implementations

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 4521:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::getStrategyHooksRoot(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeStrategyHooksRoot(address,bytes32)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeStrategyHooksRootUpdate(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GetStrategyHooksRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 1)
  │   💬 Args: [strategyRoot, bytes32(0), "Initial strategy hooks root should be zero"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 2)
  │   💬 Args: [strategyRoot, bytes32(0), "Root should still be zero before execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 3)
      💬 Args: [strategyRoot, newRoot, "Strategy hooks root should be updated"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getStrategyHooksRoot returns strategy-specific hooks root
