# Function: getInstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getInstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 9371:256:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice get callData to install fallback on an ERC7579 Account
///  @param initData bytes the data to pass to the module
///  @return data bytes the callData to install the fallback
function getInstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual public view returns (bytes memory data) {
    data = initData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.getInstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice get callData to install fallback on an ERC7579 Account
 @param initData bytes the data to pass to the module
 @return data bytes the callData to install the fallback
