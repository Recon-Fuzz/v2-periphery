# Function: decimals(address)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 826:92:357

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function decimals(address) override external pure returns (uint8) {
    return 18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakingYieldSourceOracle.decimals(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Returns the number of decimals of the yield source shares
 @dev Critical for accurately interpreting share amounts and calculating prices
      Different yield sources may have different decimal precision
 @param yieldSourceAddress The address of the yield-bearing token contract
 @return decimals The number of decimals used by the yield source's share token
