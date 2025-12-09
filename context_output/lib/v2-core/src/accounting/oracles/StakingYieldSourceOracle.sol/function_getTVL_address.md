# Function: getTVL(address)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `getTVL(address)`
- **Visibility**: public
- **Source Range**: 2362:147:357

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVL(address yieldSourceAddress) override public view returns (uint256) {
    return IERC20(yieldSourceAddress).totalSupply();
}
```

## External Calls

- **IERC20::totalSupply()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakingYieldSourceOracle.getTVL(address) (NodeID: 0)
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
