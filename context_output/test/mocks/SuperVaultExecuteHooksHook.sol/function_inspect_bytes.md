# Function: inspect(bytes)

**Contract**: [test/mocks/SuperVaultExecuteHooksHook.sol/contract_SuperVaultExecuteHooksHook.md]

## Metadata

- **Contract**: SuperVaultExecuteHooksHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 2080:510:610

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory addressData) {
    ISuperVaultStrategy.ExecuteArgs memory executeArgs = abi.decode(data, (ISuperVaultStrategy.ExecuteArgs));
    uint256 length = executeArgs.hooks.length;
    for (uint256 i; i < length; i++) {
        addressData = bytes.concat(addressData, bytes20(executeArgs.hooks[i]));
    }
    return addressData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultExecuteHooksHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
