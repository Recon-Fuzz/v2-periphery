# Function: previewDeposit(address,uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `previewDeposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 1600:116:585

## Implementation

```solidity
function previewDeposit(address, uint256 assets) public pure returns (uint256 shares) {
    return assets;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.previewDeposit(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
