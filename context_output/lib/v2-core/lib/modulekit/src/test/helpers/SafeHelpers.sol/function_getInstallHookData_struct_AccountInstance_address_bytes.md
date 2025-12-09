# Function: getInstallHookData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `getInstallHookData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 8731:311:238

## Implementation

```solidity
/// @notice Gets the data to install a hook on an account instance
///  @param initData the data to pass to the hook
///  @return data the data to install the hook
function getInstallHookData(AccountInstance memory, address, bytes memory initData) virtual override public view returns (bytes memory data) {
    data = abi.encode(HookType.GLOBAL, bytes4(0x0), initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.getInstallHookData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to install a hook on an account instance
 @param initData the data to pass to the hook
 @return data the data to install the hook
