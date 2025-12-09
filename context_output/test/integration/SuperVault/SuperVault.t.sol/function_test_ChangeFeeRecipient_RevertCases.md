# Function: test_ChangeFeeRecipient_RevertCases()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ChangeFeeRecipient_RevertCases()`
- **Visibility**: public
- **Source Range**: 408027:177:580

## Implementation

```solidity
function test_ChangeFeeRecipient_RevertCases() public {
    vm.expectRevert(ISuperVaultStrategy.ACCESS_DENIED.selector);
    strategy.changeFeeRecipient(TREASURY);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::changeFeeRecipient(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ChangeFeeRecipient_RevertCases() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
