# Function: getTVLByOwnerOfSharesMultiple(address[],address[][])

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 2820:734:638

## Implementation

```solidity
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory) {
    uint256[][] memory result = new uint256[][](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        result[i] = new uint256[](ownersOfShares[i].length);
        for (uint256 j = 0; j < ownersOfShares[i].length; j++) {
            uint256 shares = IERC4626(yieldSourceAddresses[i]).balanceOf(ownersOfShares[i][j]);
            result[i][j] = IERC4626(yieldSourceAddresses[i]).convertToAssets(shares);
        }
    }
    return result;
}
```

## External Calls

- **IERC4626::balanceOf(address)**
- **IERC4626::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getTVLByOwnerOfSharesMultiple(address[],address[][]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVLByOwnerOfShares for multiple yield sources and owners
 @dev Efficiently calculates TVL for multiple owners across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @param ownersOfShares 2D array where each sub-array contains owner addresses for a yield source
 @return userTvls 2D array of TVL values for each owner in each yield source
