# Function: getPricePerShareMultiple(address[])

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2269:210:607

## Implementation

```solidity
function getPricePerShareMultiple(address[] memory) external view returns (uint256[] memory) {
    uint256[] memory prices = new uint256[](1);
    prices[0] = pricePerShare;
    return prices;
}
```

## State Variable Reads

- **pricePerShare** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getPricePerShare for multiple yield sources
 @dev Efficiently retrieves current prices for multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return pricesPerShare Array of current prices for each yield source
