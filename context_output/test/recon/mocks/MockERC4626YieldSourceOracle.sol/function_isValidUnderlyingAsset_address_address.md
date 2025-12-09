# Function: isValidUnderlyingAsset(address,address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `isValidUnderlyingAsset(address,address)`
- **Visibility**: external
- **Source Range**: 3923:129:638

## Implementation

```solidity
function isValidUnderlyingAsset(address, address asset) external view returns (bool) {
    return validAssetMap[asset];
}
```

## State Variable Reads

- **validAssetMap** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.isValidUnderlyingAsset(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
