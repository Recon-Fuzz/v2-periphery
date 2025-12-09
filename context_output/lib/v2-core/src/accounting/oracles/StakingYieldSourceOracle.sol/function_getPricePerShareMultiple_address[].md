# Function: getPricePerShareMultiple(address[])

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
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
- **Source**: 970:102:357
- **Link**: `lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol:StakingYieldSourceOracle:getPricePerShare(address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getPricePerShare(address) override public pure returns (uint256) {
    return 1e18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StakingYieldSourceOracle.getPricePerShare(address) (NodeID: 1)
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
