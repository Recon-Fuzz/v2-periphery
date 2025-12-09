# Function: formatERC1271Hash(struct AccountInstance,address,bytes32)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `formatERC1271Hash(struct AccountInstance,address,bytes32)`
- **Visibility**: public
- **Source Range**: 18087:217:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Formats a hash for an ERC1271 signature
///  @param hash bytes32 the hash to format
///  @return bytes32 the formatted hash
function formatERC1271Hash(AccountInstance memory, address, bytes32 hash) virtual public returns (bytes32) {
    return hash;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.formatERC1271Hash(struct AccountInstance,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Formats a hash for an ERC1271 signature
 @param hash bytes32 the hash to format
 @return bytes32 the formatted hash
