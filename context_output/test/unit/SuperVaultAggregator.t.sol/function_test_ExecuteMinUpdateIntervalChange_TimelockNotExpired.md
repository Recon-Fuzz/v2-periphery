# Function: test_ExecuteMinUpdateIntervalChange_TimelockNotExpired()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteMinUpdateIntervalChange_TimelockNotExpired()`
- **Visibility**: public
- **Source Range**: 205808:618:661

## Implementation

```solidity
/// @notice Test 9: Execute before timelock reverts
function test_ExecuteMinUpdateIntervalChange_TimelockNotExpired() public {
    vm.prank(manager);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
    vm.expectRevert(ISuperVaultAggregator.TIMELOCK_NOT_EXPIRED.selector);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
    vm.warp((block.timestamp + 3 days) - 1);
    vm.expectRevert(ISuperVaultAggregator.TIMELOCK_NOT_EXPIRED.selector);
    superVaultAggregator.executeMinUpdateIntervalChange(strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::executeMinUpdateIntervalChange(address)**
- **Vm::warp(uint256)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteMinUpdateIntervalChange_TimelockNotExpired() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 9: Execute before timelock reverts
