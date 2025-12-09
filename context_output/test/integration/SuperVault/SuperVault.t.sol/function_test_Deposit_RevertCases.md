# Function: test_Deposit_RevertCases()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Deposit_RevertCases()`
- **Visibility**: public
- **Source Range**: 10230:249:580

## Implementation

```solidity
function test_Deposit_RevertCases() public {
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    vault.deposit(1000, address(0));
    vm.expectRevert(ISuperVault.ZERO_AMOUNT.selector);
    vault.deposit(0, accountEth);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVault::deposit(uint256,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Deposit_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
