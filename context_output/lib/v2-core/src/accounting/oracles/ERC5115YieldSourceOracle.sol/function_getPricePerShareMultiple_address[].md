# Function: getPricePerShareMultiple(address[])

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
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
- **Source**: 3496:170:356
- **Link**: `lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol:ERC5115YieldSourceOracle:getPricePerShare(address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address yieldSourceAddress) override public view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).exchangeRate();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getPricePerShare(address) (NodeID: 1)
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
