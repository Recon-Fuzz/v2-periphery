# Function: getUninstallFallbackData(struct AccountInstance,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getUninstallFallbackData(struct AccountInstance,address,bytes)`
- **Visibility**: public
- **Source Range**: 13364:406:236

## Implementation

```solidity
/// @notice Gets the data to uninstall a fallback on an account instance
///  @dev
///  https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L402-L403
///  @param initData the data to pass to the fallback
///  @return data the data to uninstall the fallback
function getUninstallFallbackData(AccountInstance memory, address, bytes memory initData) virtual override public pure returns (bytes memory data) {
    (bytes4 selector, , bytes memory _initData) = abi.decode(initData, (bytes4, CallType, bytes));
    data = abi.encodePacked(selector, _initData);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.getUninstallFallbackData(struct AccountInstance,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets the data to uninstall a fallback on an account instance
 @dev
 https://github.com/zerodevapp/kernel/blob/a807c8ec354a77ebb7cdb73c5be9dd315cda0df2/../../Kernel.sol#L402-L403
 @param initData the data to pass to the fallback
 @return data the data to uninstall the fallback
