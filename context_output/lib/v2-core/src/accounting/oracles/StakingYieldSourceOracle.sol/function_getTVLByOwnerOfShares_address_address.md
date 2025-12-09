# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [lib/v2-core/src/accounting/oracles/StakingYieldSourceOracle.sol/contract_StakingYieldSourceOracle.md]

## Metadata

- **Contract**: StakingYieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: public
- **Source Range**: 2056:254:357

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    return IERC20(yieldSourceAddress).balanceOf(ownerOfShares);
}
```

## External Calls

- **IERC20::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakingYieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Calculates the total value locked in a yield source by a specific owner
 @dev Used to track individual position sizes within the system
 @param yieldSourceAddress The yield-bearing token address to check
 @param ownerOfShares The address owning the yield-bearing tokens
 @return tvl The total value locked by the owner, in underlying asset terms
