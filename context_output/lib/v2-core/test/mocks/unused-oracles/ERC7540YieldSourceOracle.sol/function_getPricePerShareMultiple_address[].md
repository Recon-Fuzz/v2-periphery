# Function: getPricePerShareMultiple(address[])

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 4871:466:354
- **Inherited From**: AbstractYieldSourceOracle

## Implementation

```solidity
/// @inheritdoc IYieldSourceOracle
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory pricesPerShare) {
    uint256 length = yieldSourceAddresses.length;
    pricesPerShare = new uint256[](length);
    for (uint256 i; i < length; ++i) {
        pricesPerShare[i] = getPricePerShare(yieldSourceAddresses[i]);
    }
}
```

## Related Implementations

### getPricePerShare(address)

- **Kind**: internal
- **Source**: 2386:302:498
- **Link**: `lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol:ERC7540YieldSourceOracle:getPricePerShare(address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address yieldSourceAddress) override public view returns (uint256) {
    address share = IERC7540(yieldSourceAddress).share();
    uint256 _decimals = IERC20Metadata(share).decimals();
    return IERC7540(yieldSourceAddress).convertToAssets(10 ** _decimals);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getPricePerShare(address) (NodeID: 1)
      💬 Args: [yieldSourceAddresses[i]]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IYieldSourceOracle

### Interface Documentation

@notice Batch version of getPricePerShare for multiple yield sources
 @dev Efficiently retrieves current prices for multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return pricesPerShare Array of current prices for each yield source
