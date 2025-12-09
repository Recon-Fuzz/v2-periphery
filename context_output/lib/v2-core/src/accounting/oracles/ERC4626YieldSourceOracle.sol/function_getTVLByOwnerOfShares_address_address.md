# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: ERC4626YieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: public
- **Source Range**: 2535:397:355

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    IERC4626 yieldSource = IERC4626(yieldSourceAddress);
    uint256 shares = yieldSource.balanceOf(ownerOfShares);
    if (shares == 0) return 0;
    return yieldSource.convertToAssets(shares);
}
```

## External Calls

- **IERC4626::balanceOf(address)**
- **IERC4626::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626YieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
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
