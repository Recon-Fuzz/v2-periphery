# Function: setRugEnabled(bool)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `setRugEnabled(bool)`
- **Visibility**: external
- **Source Range**: 1670:79:608

## Implementation

```solidity
function setRugEnabled(bool value) external {
    rugEnabled = value;
}
```

## State Variable Writes

- **rugEnabled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.setRugEnabled(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
