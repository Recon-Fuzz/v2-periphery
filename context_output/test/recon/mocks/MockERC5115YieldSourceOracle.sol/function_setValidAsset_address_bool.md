# Function: setValidAsset(address,bool)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `setValidAsset(address,bool)`
- **Visibility**: external
- **Source Range**: 527:108:640

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
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.setValidAsset(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
