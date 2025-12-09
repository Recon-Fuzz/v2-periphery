# Function: setAsset(address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `setAsset(address)`
- **Visibility**: external
- **Source Range**: 1016:67:585

## Implementation

```solidity
function setAsset(address _a) external {
    _asset = _a;
}
```

## State Variable Writes

- **_asset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.setAsset(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
