# Function: test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge()`
- **Visibility**: public
- **Source Range**: 54015:869:661

## Implementation

```solidity
/// @notice Tests that proposeMinUpdateIntervalChange reverts when newInterval >= maxStaleness
function test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge() public {
    uint256 maxStaleness = superVaultAggregator.getMaxStaleness(strategy);
    uint256 invalidInterval = maxStaleness;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MIN_UPDATE_INTERVAL_TOO_HIGH.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, invalidInterval);
    invalidInterval = maxStaleness + 1;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.MIN_UPDATE_INTERVAL_TOO_HIGH.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, invalidInterval);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that proposeMinUpdateIntervalChange reverts when newInterval >= maxStaleness
