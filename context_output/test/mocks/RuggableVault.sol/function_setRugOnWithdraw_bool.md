# Function: setRugOnWithdraw(bool)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `setRugOnWithdraw(bool)`
- **Visibility**: external
- **Source Range**: 1879:85:609

## Implementation

```solidity
function setRugOnWithdraw(bool value) external {
    rugOnWithdraw = value;
}
```

## State Variable Writes

- **rugOnWithdraw** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.setRugOnWithdraw(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
