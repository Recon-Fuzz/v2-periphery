# Function: getAssetOutputWithFees(bytes32,address,address,address,uint256)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4392:287:638

## Implementation

```solidity
function getAssetOutputWithFees(bytes32, address yieldSourceAddress, address, address, uint256 sharesIn) external view returns (uint256) {
    return IERC4626(yieldSourceAddress).previewRedeem(sharesIn);
}
```

## External Calls

- **IERC4626::previewRedeem(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getAssetOutputWithFees(bytes32,address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the asset output with fees added for an outflow operation
 @dev Gets the asset output from the oracle and adds any applicable fees
      Uses try/catch to handle cases where oracle configuration doesn't exist
 @param yieldSourceOracleId Identifier for the yield source oracle configuration
 @param yieldSourceAddress Address of the yield-bearing asset
 @param assetOut Address of the output asset
 @param user Address of the user performing the outflow
 @param usedShares Amount of shares being withdrawn
 @return Total asset amount including fees
