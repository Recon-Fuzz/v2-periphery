# Function: getTVLMultiple(address[])

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
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
- **Source**: 2362:147:357
- **Link**: `lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol:StakingYieldSourceOracle:getTVL(address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVL(address yieldSourceAddress) override public view returns (uint256) {
    return IERC20(yieldSourceAddress).totalSupply();
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getTVLMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StakingYieldSourceOracle.getTVL(address) (NodeID: 1)
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
