# Function: getAssetOutput(address,address,uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1521:122:607

## Implementation

```solidity
function getAssetOutput(address, address, uint256 sharesIn) public pure returns (uint256) {
    return sharesIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Calculates the number of underlying assets that would be received for a given amount of shares
 @dev Used for withdrawal simulations and to calculate current yield
 @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
 @param assetIn The underlying asset to receive (e.g., USDC, DAI)
 @param sharesIn The amount of yield-bearing shares to redeem
 @return assets The number of underlying assets that would be received
