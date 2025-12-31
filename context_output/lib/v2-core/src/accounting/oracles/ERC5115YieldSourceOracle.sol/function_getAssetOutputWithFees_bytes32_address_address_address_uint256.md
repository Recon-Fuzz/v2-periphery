# Function: getAssetOutputWithFees(bytes32,address,address,address,uint256)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `getAssetOutputWithFees(bytes32,address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3205:1621:354
- **Inherited From**: AbstractYieldSourceOracle

## Implementation

```solidity
/// @inheritdoc IYieldSourceOracle
function getAssetOutputWithFees(bytes32 yieldSourceOracleId, address yieldSourceAddress, address assetOut, address user, uint256 usedShares) virtual external view returns (uint256) {
    uint256 assetOutput = getAssetOutput(yieldSourceAddress, assetOut, usedShares);
    try ISuperLedgerConfiguration(SUPER_LEDGER_CONFIGURATION).getYieldSourceOracleConfig(yieldSourceOracleId) returns (ISuperLedgerConfiguration.YieldSourceOracleConfig memory config) {
        if ((config.feePercent > 0) && (config.ledger != address(0))) {
            uint256 pps = IYieldSourceOracle(config.yieldSourceOracle).getPricePerShare(yieldSourceAddress);
            uint8 _decimals = IYieldSourceOracle(config.yieldSourceOracle).decimals(yieldSourceAddress);
            uint256 feeAmount = ISuperLedger(config.ledger).previewFees(user, yieldSourceAddress, assetOutput, usedShares, config.feePercent, pps, _decimals);
            return assetOutput + feeAmount;
        }
        return assetOutput;
    } catch {
        return assetOutput;
    }
}
```

## Related Implementations

### getAssetOutput(address,address,uint256)

- **Kind**: internal
- **Source**: 3155:289:356
- **Link**: `lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol:ERC5115YieldSourceOracle:getAssetOutput(address,address,uint256)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getAssetOutput(address yieldSourceAddress, address assetOut, uint256 sharesIn) override public view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).previewRedeem(assetOut, sharesIn);
}
```

## External Calls

- **ISuperLedgerConfiguration::getYieldSourceOracleConfig(bytes32)**
- **IYieldSourceOracle::getPricePerShare(address)**
- **IYieldSourceOracle::decimals(address)**
- **ISuperLedger::previewFees(address,address,uint256,uint256,uint256,uint256,uint256)**
- **IERC4626::previewRedeem(uint256)**

## State Variable Reads

- **SUPER_LEDGER_CONFIGURATION** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getAssetOutputWithFees(bytes32,address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getAssetOutput(address,address,uint256) (NodeID: 1)
      💬 Args: [yieldSourceAddress, assetOut, usedShares]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IYieldSourceOracle

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
