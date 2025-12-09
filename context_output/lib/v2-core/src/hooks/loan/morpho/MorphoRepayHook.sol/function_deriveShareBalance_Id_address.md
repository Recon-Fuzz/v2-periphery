# Function: deriveShareBalance(Id,address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
- **Signature**: `deriveShareBalance(Id,address)`
- **Visibility**: public
- **Source Range**: 5780:172:378

## Implementation

```solidity
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
┌─ [0] ⚙️ FUNCTION: MorphoRepayHook.deriveShareBalance(Id,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
