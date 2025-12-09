# Function: getPricePerShareMultiple(address[])

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2318:496:638

## Implementation

```solidity
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory) {
    uint256[] memory prices = new uint256[](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        IERC4626 yieldSource = IERC4626(yieldSourceAddresses[i]);
        uint256 _decimals = yieldSource.decimals();
        prices[i] = yieldSource.convertToAssets(10 ** _decimals);
    }
    return prices;
}
```

## External Calls

- **IERC4626::decimals()**
- **IERC4626::convertToAssets(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getPricePerShare for multiple yield sources
 @dev Efficiently retrieves current prices for multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return pricesPerShare Array of current prices for each yield source
