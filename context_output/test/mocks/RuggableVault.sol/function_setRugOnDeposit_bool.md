# Function: setRugOnDeposit(bool)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `setRugOnDeposit(bool)`
- **Visibility**: external
- **Source Range**: 1790:83:609

## Implementation

```solidity
function setRugOnDeposit(bool value) external {
    rugOnDeposit = value;
}
```

## State Variable Writes

- **rugOnDeposit** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.setRugOnDeposit(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
