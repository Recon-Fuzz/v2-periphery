# Function: setLessAmount(bool)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `setLessAmount(bool)`
- **Visibility**: external
- **Source Range**: 1261:91:585

## Implementation

```solidity
function setLessAmount(bool lessAmount_) external {
    lessAmount = lessAmount_;
}
```

## State Variable Writes

- **lessAmount** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.setLessAmount(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
