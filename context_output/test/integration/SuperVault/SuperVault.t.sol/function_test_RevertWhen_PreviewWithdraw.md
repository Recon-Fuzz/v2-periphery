# Function: test_RevertWhen_PreviewWithdraw()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_PreviewWithdraw()`
- **Visibility**: public
- **Source Range**: 55237:268:580

## Implementation

```solidity
function test_RevertWhen_PreviewWithdraw() public {
    uint256 amount = 1000e6;
    vm.expectRevert(ISuperVault.NOT_IMPLEMENTED.selector);
    vault.previewWithdraw(amount);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVault::previewWithdraw(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_PreviewWithdraw() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
