# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 1894:270:638

## Implementation

```solidity
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) external view returns (uint256) {
    uint256 shares = IERC4626(yieldSourceAddress).balanceOf(ownerOfShares);
    return IERC4626(yieldSourceAddress).convertToAssets(shares);
}
```

## External Calls

- **IERC4626::balanceOf(address)**
- **IERC4626::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked in a yield source by a specific owner
 @dev Used to track individual position sizes within the system
 @param yieldSourceAddress The yield-bearing token address to check
 @param ownerOfShares The address owning the yield-bearing tokens
 @return tvl The total value locked by the owner, in underlying asset terms
