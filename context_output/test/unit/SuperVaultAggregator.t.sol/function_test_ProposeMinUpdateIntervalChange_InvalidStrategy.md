# Function: test_ProposeMinUpdateIntervalChange_InvalidStrategy()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_InvalidStrategy()`
- **Visibility**: public
- **Source Range**: 204428:306:661

## Implementation

```solidity
/// @notice Test 6: Invalid strategy reverts
function test_ProposeMinUpdateIntervalChange_InvalidStrategy() public {
    address fakeStrategy = address(0xdead);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(fakeStrategy, 10);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_InvalidStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 6: Invalid strategy reverts
