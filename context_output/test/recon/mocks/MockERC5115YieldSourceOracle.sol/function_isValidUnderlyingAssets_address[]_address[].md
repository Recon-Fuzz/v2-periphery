# Function: isValidUnderlyingAssets(address[],address[])

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `isValidUnderlyingAssets(address[],address[])`
- **Visibility**: external
- **Source Range**: 4656:328:640

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
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.isValidUnderlyingAssets(address[],address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
