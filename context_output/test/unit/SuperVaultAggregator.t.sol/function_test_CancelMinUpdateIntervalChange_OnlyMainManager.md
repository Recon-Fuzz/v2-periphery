# Function: test_CancelMinUpdateIntervalChange_OnlyMainManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_CancelMinUpdateIntervalChange_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 215798:440:661

## Implementation

```solidity
/// @notice Test 17: Only main manager can cancel
function test_CancelMinUpdateIntervalChange_OnlyMainManager() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 100);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    vm.prank(address(0x1234));
    superVaultAggregator.cancelMinUpdateIntervalChange(strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::cancelMinUpdateIntervalChange(address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_CancelMinUpdateIntervalChange_OnlyMainManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 17: Only main manager can cancel
