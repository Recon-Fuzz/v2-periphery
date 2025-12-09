# Function: test_Deposit_RevertWhen_ZeroAmount()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Deposit_RevertWhen_ZeroAmount()`
- **Visibility**: public
- **Source Range**: 10547:216:580

## Implementation

```solidity
/// @notice Dedicated test for zero amount deposit revert
function test_Deposit_RevertWhen_ZeroAmount() public {
    vm.startPrank(accountEth);
    vm.expectRevert(ISuperVault.ZERO_AMOUNT.selector);
    vault.deposit(0, accountEth);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::deposit(uint256,address)**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Deposit_RevertWhen_ZeroAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Dedicated test for zero amount deposit revert
