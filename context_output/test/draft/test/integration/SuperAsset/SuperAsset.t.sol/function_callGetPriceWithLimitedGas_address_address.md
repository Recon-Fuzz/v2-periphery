# Function: callGetPriceWithLimitedGas(address,address)

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `callGetPriceWithLimitedGas(address,address)`
- **Visibility**: external
- **Source Range**: 29854:256:565

## Implementation

```solidity
function callGetPriceWithLimitedGas(address superAsset_, address token_) external view returns (uint256, bool, bool, bool) {
    return ISuperAsset(superAsset_).getPriceAndCircuitBreakers(token_);
}
```

## External Calls

- **ISuperAsset::getPriceAndCircuitBreakers(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.callGetPriceWithLimitedGas(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
