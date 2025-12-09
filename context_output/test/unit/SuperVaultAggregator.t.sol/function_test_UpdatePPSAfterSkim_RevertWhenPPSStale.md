# Function: test_UpdatePPSAfterSkim_RevertWhenPPSStale()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpdatePPSAfterSkim_RevertWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 24380:1219:661

## Implementation

```solidity
/// @notice Tests that updatePPSAfterSkim reverts when PPS is stale
function test_UpdatePPSAfterSkim_RevertWhenPPSStale() public {
    uint256 currentPPS = superVaultAggregator.getPPS(strategy);
    assertTrue(currentPPS > 0, "Initial PPS should be positive");
    uint256 newPPS = (currentPPS * 99) / 100;
    vm.prank(manager);
    superVaultAggregator.pauseStrategy(strategy);
    assertTrue(superVaultAggregator.isPPSStale(strategy), "PPS should be stale after pause");
    vm.prank(manager);
    superVaultAggregator.unpauseStrategy(strategy);
    assertFalse(superVaultAggregator.isStrategyPaused(strategy), "Strategy should be unpaused");
    assertTrue(superVaultAggregator.isPPSStale(strategy), "PPS should still be stale after unpause");
    vm.prank(strategy);
    vm.expectRevert(ISuperVaultAggregator.PPS_STALE.selector);
    superVaultAggregator.updatePPSAfterSkim(newPPS, 100e18);
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

## External Calls

- **SuperVaultAggregator::getPPS(address)**
- **Vm::prank(address)**
- **SuperVaultAggregator::pauseStrategy(address)**
- **SuperVaultAggregator::isPPSStale(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::updatePPSAfterSkim(uint256,uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpdatePPSAfterSkim_RevertWhenPPSStale() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [currentPPS > 0, "Initial PPS should be positive"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.isPPSStale(strategy), "PPS should be stale after pause"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [superVaultAggregator.isStrategyPaused(strategy), "Strategy should be unpaused"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [superVaultAggregator.isPPSStale(strategy), "PPS should still be stale after unpause"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that updatePPSAfterSkim reverts when PPS is stale
