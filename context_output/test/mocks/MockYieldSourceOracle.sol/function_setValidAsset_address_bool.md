# Function: setValidAsset(address,bool)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `setValidAsset(address,bool)`
- **Visibility**: external
- **Source Range**: 1048:108:607

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
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.setValidAsset(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
