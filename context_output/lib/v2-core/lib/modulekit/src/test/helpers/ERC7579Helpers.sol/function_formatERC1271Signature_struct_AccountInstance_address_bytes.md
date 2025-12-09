# Function: formatERC1271Signature(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `formatERC1271Signature(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 5373:286:234

## Implementation

```solidity
/// @notice Format a ERC1271 signature for an account
///  @param validator address the address of the validator
///  @param signature bytes the signature to format
function formatERC1271Signature(AccountInstance memory, address validator, bytes memory signature) virtual override public returns (bytes memory) {
    return abi.encodePacked(validator, signature);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Helpers.formatERC1271Signature(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Format a ERC1271 signature for an account
 @param validator address the address of the validator
 @param signature bytes the signature to format
