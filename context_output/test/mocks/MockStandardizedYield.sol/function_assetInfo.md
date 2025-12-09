# Function: assetInfo()

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `assetInfo()`
- **Visibility**: external
- **Source Range**: 971:214:603

## Implementation

```solidity
function assetInfo() external view returns (AssetType assetType, address assetAddress, uint8 assetDecimals) {
    assetType = assetTokenType;
    assetAddress = assetToken;
    assetDecimals = 18;
}
```

## State Variable Reads

- **assetTokenType** (`enum MockStandardizedYield.AssetType`)
- **assetToken** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.assetInfo() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
