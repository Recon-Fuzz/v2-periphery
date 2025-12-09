# Function: setAsset(address)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `setAsset(address)`
- **Visibility**: external
- **Source Range**: 1380:74:593

## Implementation

```solidity
function setAsset(address _asset) external {
    asset = _asset;
}
```

## State Variable Writes

- **asset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.setAsset(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
