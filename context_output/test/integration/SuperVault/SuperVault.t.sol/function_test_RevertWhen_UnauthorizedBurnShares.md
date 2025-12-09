# Function: test_RevertWhen_UnauthorizedBurnShares()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_RevertWhen_UnauthorizedBurnShares()`
- **Visibility**: public
- **Source Range**: 66498:279:580

## Implementation

```solidity
function test_RevertWhen_UnauthorizedBurnShares() public {
    uint256 burnAmount = 1000e6;
    vm.prank(accountEth);
    vm.expectRevert(ISuperVault.UNAUTHORIZED.selector);
    vault.burnShares(burnAmount);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::burnShares(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_RevertWhen_UnauthorizedBurnShares() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
