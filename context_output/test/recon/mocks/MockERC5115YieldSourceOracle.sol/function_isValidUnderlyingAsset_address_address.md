# Function: isValidUnderlyingAsset(address,address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `isValidUnderlyingAsset(address,address)`
- **Visibility**: external
- **Source Range**: 4521:129:640

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
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.isValidUnderlyingAsset(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
