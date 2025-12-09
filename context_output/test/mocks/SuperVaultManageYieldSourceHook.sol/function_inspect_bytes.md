# Function: inspect(bytes)

**Contract**: [test/mocks/SuperVaultManageYieldSourceHook.sol/contract_SuperVaultManageYieldSourceHook.md]

## Metadata

- **Contract**: SuperVaultManageYieldSourceHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 2317:544:611

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory addressData) {
    ManageYieldSourcesArgs memory args = abi.decode(data, (ManageYieldSourcesArgs));
    for (uint256 i = 0; i < args.sources.length; i++) {
        addressData = bytes.concat(addressData, bytes20(args.sources[i]));
        addressData = bytes.concat(addressData, bytes20(args.oracles[i]));
    }
    return addressData;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultManageYieldSourceHook.inspect(bytes) (NodeID: 0)
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
