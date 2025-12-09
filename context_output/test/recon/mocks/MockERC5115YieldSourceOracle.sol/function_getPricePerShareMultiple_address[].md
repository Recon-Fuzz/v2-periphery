# Function: getPricePerShareMultiple(address[])

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getPricePerShareMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2779:383:640

## Implementation

```solidity
function getPricePerShareMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory) {
    uint256[] memory prices = new uint256[](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        prices[i] = MockERC5115Tester(yieldSourceAddresses[i]).exchangeRate();
    }
    return prices;
}
```

## External Calls

- **MockERC5115Tester::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getPricePerShareMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getPricePerShare for multiple yield sources
 @dev Efficiently retrieves current prices for multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return pricesPerShare Array of current prices for each yield source
