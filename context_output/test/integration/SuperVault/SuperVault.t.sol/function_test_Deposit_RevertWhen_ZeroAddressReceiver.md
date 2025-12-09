# Function: test_Deposit_RevertWhen_ZeroAddressReceiver()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Deposit_RevertWhen_ZeroAddressReceiver()`
- **Visibility**: public
- **Source Range**: 10833:231:580

## Implementation

```solidity
/// @notice Dedicated test for zero address receiver revert
function test_Deposit_RevertWhen_ZeroAddressReceiver() public {
    vm.startPrank(accountEth);
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    vault.deposit(1000e6, address(0));
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Deposit_RevertWhen_ZeroAddressReceiver() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Dedicated test for zero address receiver revert
