# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/vaults/7540/Deposit7540VaultHook.sol/contract_Deposit7540VaultHook.md]

## Metadata

- **Contract**: Deposit7540VaultHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 3243:151:410

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    return abi.encodePacked(data.extractYieldSource());
}
```

## Related Implementations

### extractYieldSource(bytes)

- **Kind**: internal
- **Source**: 396:131:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSource(bytes)`

```solidity
function extractYieldSource(bytes memory data) internal pure returns (address) {
    return BytesLib.toAddress(data, 32);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Deposit7540VaultHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 1)
      💬 Args: [data]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
        💬 Args: [data, 32]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
