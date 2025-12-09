# Function: getUninstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getUninstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 3728:406:234

## Implementation

```solidity
/// @notice get callData to uninstall a fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Helpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to uninstall a fallback on an ERC7579 Account
 @param initData bytes the data to pass to the module
