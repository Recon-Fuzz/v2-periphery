# Function: getAssetOutput(address,address,uint256)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getAssetOutput(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1237:185:638

## Implementation

```solidity
function getAssetOutput(address yieldSourceAddress, address, uint256 sharesIn) public view returns (uint256) {
    return IERC4626(yieldSourceAddress).previewRedeem(sharesIn);
}
```

## External Calls

- **IERC4626::previewRedeem(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 0)
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
