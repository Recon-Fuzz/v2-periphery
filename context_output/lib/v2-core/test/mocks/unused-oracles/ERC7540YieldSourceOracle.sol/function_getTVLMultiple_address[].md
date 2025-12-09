# Function: getTVLMultiple(address[])

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 6603:358:354
- **Inherited From**: AbstractYieldSourceOracle

## Implementation

```solidity
/// @inheritdoc IYieldSourceOracle
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory tvls) {
    uint256 length = yieldSourceAddresses.length;
    tvls = new uint256[](length);
    for (uint256 i; i < length; ++i) {
        tvls[i] = getTVL(yieldSourceAddresses[i]);
    }
}
```

## Related Implementations

### getTVL(address)

- **Kind**: internal
- **Source**: 3498:149:498
- **Link**: `lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol:ERC7540YieldSourceOracle:getTVL(address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVL(address yieldSourceAddress) override public view returns (uint256) {
    return IERC7540(yieldSourceAddress).totalAssets();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getTVLMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getTVL(address) (NodeID: 1)
      💬 Args: [yieldSourceAddresses[i]]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IYieldSourceOracle

### Interface Documentation

@notice Batch version of getTVL for multiple yield sources
 @dev Efficiently calculates total TVL across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return tvls Array containing the total TVL for each yield source
