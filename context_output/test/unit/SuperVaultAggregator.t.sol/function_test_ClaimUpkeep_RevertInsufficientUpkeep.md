# Function: test_ClaimUpkeep_RevertInsufficientUpkeep()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ClaimUpkeep_RevertInsufficientUpkeep()`
- **Visibility**: public
- **Source Range**: 26618:434:661

## Implementation

```solidity
/// @notice Tests that claimUpkeep reverts when insufficient claimable upkeep
function test_ClaimUpkeep_RevertInsufficientUpkeep() public {
    uint256 currentClaimable = superVaultAggregator.claimableUpkeep();
    vm.prank(address(superGovernor));
    vm.expectRevert(ISuperVaultAggregator.INSUFFICIENT_UPKEEP.selector);
    superVaultAggregator.claimUpkeep(currentClaimable + 1);
}
```

## External Calls

- **SuperVaultAggregator::claimableUpkeep()**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::claimUpkeep(uint256)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ClaimUpkeep_RevertInsufficientUpkeep() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that claimUpkeep reverts when insufficient claimable upkeep
