# Function: test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness()`
- **Visibility**: public
- **Source Range**: 204802:643:661

## Implementation

```solidity
/// @notice Test 7: Interval exceeds maxStaleness reverts
function test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness() public {
    uint256 maxStaleness = superVaultAggregator.getMaxStaleness(strategy);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MIN_UPDATE_INTERVAL_TOO_HIGH.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, maxStaleness);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MIN_UPDATE_INTERVAL_TOO_HIGH.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, maxStaleness + 1);
}
```

## External Calls

- **SuperVaultAggregator::getMaxStaleness(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 7: Interval exceeds maxStaleness reverts
