# Function: getPricePerShare(address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getPricePerShare(address)`
- **Visibility**: external
- **Source Range**: 1428:267:638

## Implementation

```solidity
function getPricePerShare(address yieldSourceAddress) external view returns (uint256) {
    IERC4626 yieldSource = IERC4626(yieldSourceAddress);
    uint256 _decimals = yieldSource.decimals();
    return yieldSource.convertToAssets(10 ** _decimals);
}
```

## External Calls

- **IERC4626::decimals()**
- **IERC4626::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getPricePerShare(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Retrieves the current price per share in terms of the underlying asset
 @dev Core function for calculating yields and determining returns
 @param yieldSourceAddress The yield-bearing token address to get the price for
 @return pricePerShare The current price per share in underlying asset terms, scaled by decimals
