# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: public
- **Source Range**: 3060:386:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    uint256 shares = IERC20(IERC7540(yieldSourceAddress).share()).balanceOf(ownerOfShares);
    if (shares == 0) return 0;
    return IERC7540(yieldSourceAddress).convertToAssets(shares);
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC7540::share()**
- **IERC7540::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
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
