# Function: isValidUnderlyingAssets(address[],address[])

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `isValidUnderlyingAssets(address[],address[])`
- **Visibility**: external
- **Source Range**: 4058:328:638

## Implementation

```solidity
function isValidUnderlyingAssets(address[] memory, address[] memory assets) external view returns (bool[] memory) {
    bool[] memory validities = new bool[](assets.length);
    for (uint256 i = 0; i < assets.length; i++) {
        validities[i] = validAssetMap[assets[i]];
    }
    return validities;
}
```

## State Variable Reads

- **validAssetMap** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.isValidUnderlyingAssets(address[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
