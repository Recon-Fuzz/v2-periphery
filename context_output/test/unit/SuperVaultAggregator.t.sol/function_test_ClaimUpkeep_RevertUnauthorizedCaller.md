# Function: test_ClaimUpkeep_RevertUnauthorizedCaller()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ClaimUpkeep_RevertUnauthorizedCaller()`
- **Visibility**: public
- **Source Range**: 25851:679:661

## Implementation

```solidity
/// @notice Tests that claimUpkeep reverts when caller is not SUPER_GOVERNOR
function test_ClaimUpkeep_RevertUnauthorizedCaller() public {
    uint256 amount = 100e18;
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.CALLER_NOT_AUTHORIZED.selector);
    superVaultAggregator.claimUpkeep(amount);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.CALLER_NOT_AUTHORIZED.selector);
    superVaultAggregator.claimUpkeep(amount);
    vm.prank(strategy);
    vm.expectRevert(ISuperVaultAggregator.CALLER_NOT_AUTHORIZED.selector);
    superVaultAggregator.claimUpkeep(amount);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::claimUpkeep(uint256)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ClaimUpkeep_RevertUnauthorizedCaller() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that claimUpkeep reverts when caller is not SUPER_GOVERNOR
