# Function: getUninstallHookData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getUninstallHookData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 9226:313:238

## Implementation

```solidity
/// @notice Gets the data to uninstall a hook on an account instance
///  @param initData the data to pass to the hook
///  @return data the data to uninstall the hook
function getUninstallHookData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    data = abi.encode(HookType.GLOBAL, bytes4(0x0), initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getUninstallHookData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to uninstall a hook on an account instance
 @param initData the data to pass to the hook
 @return data the data to uninstall the hook
