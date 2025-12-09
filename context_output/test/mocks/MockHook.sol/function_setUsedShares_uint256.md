# Function: setUsedShares(uint256)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `setUsedShares(uint256)`
- **Visibility**: external
- **Source Range**: 1062:94:593

## Implementation

```solidity
function setUsedShares(uint256 _usedShares) external {
    usedShares = _usedShares;
}
```

## State Variable Writes

- **usedShares** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.setUsedShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
