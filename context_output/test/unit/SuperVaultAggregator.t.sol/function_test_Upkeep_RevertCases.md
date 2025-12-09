# Function: test_Upkeep_RevertCases()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_Upkeep_RevertCases()`
- **Visibility**: public
- **Source Range**: 126784:334:661

## Implementation

```solidity
function test_Upkeep_RevertCases() public {
    vm.expectRevert(ISuperVaultAggregator.ZERO_AMOUNT.selector);
    superVaultAggregator.depositUpkeep(strategy, 0);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_AMOUNT.selector);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::prank(address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_Upkeep_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
