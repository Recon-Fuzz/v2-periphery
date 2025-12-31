# Function: deriveShareBalance(Id,address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayAndWithdrawHook.sol/contract_MorphoRepayAndWithdrawHook.md]

## Metadata

- **Contract**: MorphoRepayAndWithdrawHook
- **Signature**: `deriveShareBalance(Id,address)`
- **Visibility**: public
- **Source Range**: 7030:172:377

## Implementation

```solidity
/// @dev derive the share balance of the account
///  @param id the id of the market
///  @param account the account to derive the share balance for
///  @return borrowShares the share balance of the account
function deriveShareBalance(Id id, address account) public view returns (uint128 borrowShares) {
    (, borrowShares, ) = morphoStaticTyping.position(id, account);
}
```

## External Calls

- **IMorphoStaticTyping::position(Id,address)**

## State Variable Reads

- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayAndWithdrawHook.deriveShareBalance(Id,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev derive the share balance of the account
 @param id the id of the market
 @param account the account to derive the share balance for
 @return borrowShares the share balance of the account
