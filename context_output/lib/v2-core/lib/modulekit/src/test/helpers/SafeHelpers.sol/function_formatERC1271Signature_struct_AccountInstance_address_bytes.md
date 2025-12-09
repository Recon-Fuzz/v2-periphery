# Function: formatERC1271Signature(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `formatERC1271Signature(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 15858:286:238

## Implementation

```solidity
/// @notice Format a ERC1271 signature for an account
///  @param validator address the address of the validator
///  @param signature bytes the signature to format
///  @return bytes the formatted signature
function formatERC1271Signature(AccountInstance memory, address validator, bytes memory signature) virtual override public returns (bytes memory) {
    return abi.encodePacked(validator, signature);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.formatERC1271Signature(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Format a ERC1271 signature for an account
 @param validator address the address of the validator
 @param signature bytes the signature to format
 @return bytes the formatted signature
