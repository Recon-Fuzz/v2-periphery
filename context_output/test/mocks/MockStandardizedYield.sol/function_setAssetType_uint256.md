# Function: setAssetType(uint256)

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `setAssetType(uint256)`
- **Visibility**: external
- **Source Range**: 1191:106:603

## Implementation

```solidity
function setAssetType(uint256 _assetType) external {
    assetTokenType = AssetType(_assetType);
}
```

## State Variable Writes

- **assetTokenType** (`enum MockStandardizedYield.AssetType`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.setAssetType(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
