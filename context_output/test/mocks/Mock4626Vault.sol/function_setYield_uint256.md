# Function: setYield(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `setYield(uint256)`
- **Visibility**: external
- **Source Range**: 1181:74:585

## Implementation

```solidity
function setYield(uint256 yield_) external {
    yield = yield_;
}
```

## State Variable Writes

- **yield** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.setYield(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
