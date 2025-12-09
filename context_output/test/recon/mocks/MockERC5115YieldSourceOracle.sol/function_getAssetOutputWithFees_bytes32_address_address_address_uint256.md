# Function: getAssetOutputWithFees(bytes32,address,address,address,uint256)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 4990:315:640

## Implementation

```solidity
function getAssetOutputWithFees(bytes32, address yieldSourceAddress, address assetOut, address, uint256 sharesIn) external view returns (uint256) {
    return MockERC5115Tester(yieldSourceAddress).previewRedeem(assetOut, sharesIn);
}
```

## External Calls

- **MockERC5115Tester::previewRedeem(address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getAssetOutputWithFees(bytes32,address,address,address,uint256) (NodeID: 0)
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
