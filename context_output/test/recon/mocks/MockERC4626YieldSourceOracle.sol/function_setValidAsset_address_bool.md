# Function: setValidAsset(address,bool)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `setValidAsset(address,bool)`
- **Visibility**: external
- **Source Range**: 521:108:638

## Implementation

```solidity
function setValidAsset(address asset, bool isValid) external {
    validAssetMap[asset] = isValid;
}
```

## State Variable Writes

- **validAssetMap** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.setValidAsset(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
