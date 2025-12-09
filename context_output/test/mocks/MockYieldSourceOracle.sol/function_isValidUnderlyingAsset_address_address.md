# Function: isValidUnderlyingAsset(address,address)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `isValidUnderlyingAsset(address,address)`
- **Visibility**: external
- **Source Range**: 3119:129:607

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
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.isValidUnderlyingAsset(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
