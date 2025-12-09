# Function: getShareOutput(address,address,uint256)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getShareOutput(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 780:188:638

## Implementation

```solidity
function getShareOutput(address yieldSourceAddress, address, uint256 assetsIn) external view returns (uint256) {
    return IERC4626(yieldSourceAddress).previewDeposit(assetsIn);
}
```

## External Calls

- **IERC4626::previewDeposit(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getShareOutput(address,address,uint256) (NodeID: 0)
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
