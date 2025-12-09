# Function: getWithdrawalShareOutput(address,address,uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getWithdrawalShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1381:134:607

## Implementation

```solidity
function getWithdrawalShareOutput(address, address, uint256 assetsIn) external pure returns (uint256) {
    return assetsIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getWithdrawalShareOutput(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the amount of shares that would be burnt when withdrawing a given amount of assets
 @dev Used by oracles to simulate withdrawals and to derive the current exchange rate
 @param yieldSourceAddress The address of the yield-bearing token (e.g., aUSDC, cDAI)
 @param assetIn The address of the underlying asset to be withdrawn (e.g., USDC, DAI)
 @param assetsIn The amount of underlying assets to withdraw, denominated in the asset’s native units
 @return shares The amount of yield-bearing shares that would be burnt after withdrawal
