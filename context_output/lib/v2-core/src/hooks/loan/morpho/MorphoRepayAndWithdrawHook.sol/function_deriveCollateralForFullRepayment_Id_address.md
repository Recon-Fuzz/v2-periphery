# Function: deriveCollateralForFullRepayment(Id,address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `deriveCollateralForFullRepayment(Id,address)`
- **Visibility**: public
- **Source Range**: 7448:244:377

## Implementation

```solidity
/// @dev derive the collateral balance of the account
///  @param id the id of the market
///  @param account the account to derive the collateral balance for
///  @return collateralAmount the collateral balance of the account
function deriveCollateralForFullRepayment(Id id, address account) public view returns (uint256 collateralAmount) {
    (, , uint128 collateral) = morphoStaticTyping.position(id, account);
    collateralAmount = uint256(collateral);
}
```

## External Calls

- **IMorphoStaticTyping::position(Id,address)**

## State Variable Reads

- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveCollateralForFullRepayment(Id,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev derive the collateral balance of the account
 @param id the id of the market
 @param account the account to derive the collateral balance for
 @return collateralAmount the collateral balance of the account
