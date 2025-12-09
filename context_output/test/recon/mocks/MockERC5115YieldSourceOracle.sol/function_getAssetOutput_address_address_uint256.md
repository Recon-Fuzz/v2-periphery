# Function: getAssetOutput(address,address,uint256)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1475:271:640

## Implementation

```solidity
function getAssetOutput(address yieldSourceAddress, address assetOut, uint256 sharesIn) public view returns (uint256) {
    return MockERC5115Tester(yieldSourceAddress).previewRedeem(assetOut, sharesIn);
}
```

## External Calls

- **MockERC5115Tester::previewRedeem(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
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
