# Function: test_Mint_RevertCases()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Mint_RevertCases()`
- **Visibility**: public
- **Source Range**: 14916:240:580

## Implementation

```solidity
function test_Mint_RevertCases() public {
    vm.expectRevert(ISuperVault.ZERO_ADDRESS.selector);
    vault.mint(1000, address(0));
    vm.expectRevert(ISuperVault.ZERO_AMOUNT.selector);
    vault.mint(0, accountEth);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVault::mint(uint256,address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Mint_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
