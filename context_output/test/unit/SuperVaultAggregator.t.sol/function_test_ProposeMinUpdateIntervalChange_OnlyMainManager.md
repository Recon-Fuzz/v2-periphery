# Function: test_ProposeMinUpdateIntervalChange_OnlyMainManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeMinUpdateIntervalChange_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 203816:557:661

## Implementation

```solidity
/// @notice Test 5: Only main manager can propose
function test_ProposeMinUpdateIntervalChange_OnlyMainManager() public {
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.proposeMinUpdateIntervalChange(strategy, 10);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeMinUpdateIntervalChange(address,uint256)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeMinUpdateIntervalChange_OnlyMainManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 5: Only main manager can propose
