# Function: getShareOutput(address,address,uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1251:124:607

## Implementation

```solidity
function getShareOutput(address, address, uint256 assetsIn) external pure returns (uint256) {
    return assetsIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getShareOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the number of shares that would be received for a given amount of assets
 @dev Used for deposit simulations and to calculate current exchange rates
 @param yieldSourceAddress The yield-bearing token address (e.g., aUSDC, cDAI)
 @param assetIn The underlying asset being deposited (e.g., USDC, DAI)
 @param assetsIn The amount of underlying assets to deposit, in the asset's native units
 @return shares The number of yield-bearing shares that would be received
