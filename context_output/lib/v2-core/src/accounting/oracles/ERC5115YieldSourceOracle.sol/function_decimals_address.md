# Function: decimals(address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: public
- **Source Range**: 2110:163:356

## Implementation

```solidity
/// exchangeRate() returns price scaled to 1e18 precision, independent of SY token or asset decimals.
///  This ensures correct normalization in mulDiv operations.
///  See https://eips.ethereum.org/EIPS/eip-5115#methods -> exchangeRate()
///  The name decimals() here is ambiguous because it is a function used in other areas of the code for scaling (but
///  it doesn't refer to the SY decimals) 
///  Calculation Examples in the Oracle:
///  - In getTVL: Math.mulDiv(totalShares, yieldSource.exchangeRate(), 1e18). Here, totalShares is in SY decimals
///  (D), exchangeRate is (totalAssets * 1e18) / totalShares (per EIP, with totalAssets in asset decimals A). This
///  simplifies to totalAssets, correctly outputting the asset amount regardless of D or A.
///  - In getWithdrawalShareOutput: previewRedeem(assetIn, 1e18) gets assets for 1e18 SY share units, then
///  mulDiv(assetsIn, 1e18, assetsPerShare, Ceil) computes the required share units. The 1e18 acts as a precision
///  scaler (matching EIP), not an assumption about D. For example, with a 6-decimal SY (like Pendle's SY-syrupUSDC)
///  and initial 1:1 rate, it correctly computes shares without issues.
///  - This pattern holds for other functions like getAssetOutput (direct previewRedeem without scaling assumptions).
function decimals(address) override public pure returns (uint8) {
    return 18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115YieldSourceOracle.decimals(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

exchangeRate() returns price scaled to 1e18 precision, independent of SY token or asset decimals.
 This ensures correct normalization in mulDiv operations.
 See https://eips.ethereum.org/EIPS/eip-5115#methods -> exchangeRate()
 The name decimals() here is ambiguous because it is a function used in other areas of the code for scaling (but
 it doesn't refer to the SY decimals) 
 Calculation Examples in the Oracle:
 - In getTVL: Math.mulDiv(totalShares, yieldSource.exchangeRate(), 1e18). Here, totalShares is in SY decimals
 (D), exchangeRate is (totalAssets * 1e18) / totalShares (per EIP, with totalAssets in asset decimals A). This
 simplifies to totalAssets, correctly outputting the asset amount regardless of D or A.
 - In getWithdrawalShareOutput: previewRedeem(assetIn, 1e18) gets assets for 1e18 SY share units, then
 mulDiv(assetsIn, 1e18, assetsPerShare, Ceil) computes the required share units. The 1e18 acts as a precision
 scaler (matching EIP), not an assumption about D. For example, with a 6-decimal SY (like Pendle's SY-syrupUSDC)
 and initial 1:1 rate, it correctly computes shares without issues.
 - This pattern holds for other functions like getAssetOutput (direct previewRedeem without scaling assumptions).

### Interface Documentation

@notice Returns the number of decimals of the yield source shares
 @dev Critical for accurately interpreting share amounts and calculating prices
      Different yield sources may have different decimal precision
 @param yieldSourceAddress The address of the yield-bearing token contract
 @return decimals The number of decimals used by the yield source's share token
