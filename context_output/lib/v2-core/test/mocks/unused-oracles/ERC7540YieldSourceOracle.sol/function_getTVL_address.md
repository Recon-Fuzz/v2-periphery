# Function: getTVL(address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getTVL(address)`
- **Visibility**: public
- **Source Range**: 3498:149:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVL(address yieldSourceAddress) override public view returns (uint256) {
    return IERC7540(yieldSourceAddress).totalAssets();
}
```

## External Calls

- **IERC7540::totalAssets()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getTVL(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Calculates the total value locked across all users in a yield source
 @dev Critical for monitoring the size of each yield source in the system
 @param yieldSourceAddress The yield-bearing token address to check
 @return tvl The total value locked in the yield source, in underlying asset terms
