# Function: getAssetOutputWithFees(bytes32,address,address,address,uint256)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1649:176:607

## Implementation

```solidity
function getAssetOutputWithFees(bytes32, address, address, address, uint256 sharesIn) public pure returns (uint256) {
    return sharesIn;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getAssetOutputWithFees(bytes32,address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
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
