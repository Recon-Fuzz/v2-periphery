# Function: test_RevertWhen_PreviewRedeem()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_PreviewRedeem()`
- **Visibility**: public
- **Source Range**: 55511:264:580

## Implementation

```solidity
function test_RevertWhen_PreviewRedeem() public {
    uint256 amount = 1000e6;
    vm.expectRevert(ISuperVault.NOT_IMPLEMENTED.selector);
    vault.previewRedeem(amount);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVault::previewRedeem(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_PreviewRedeem() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
