# Function: getInstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `getInstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 3142:444:234

## Implementation

```solidity
/// @notice get callData to install a fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, CallType callType, bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, callType, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579Helpers.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install a fallback on an ERC7579 Account
 @param initData bytes the data to pass to the module
