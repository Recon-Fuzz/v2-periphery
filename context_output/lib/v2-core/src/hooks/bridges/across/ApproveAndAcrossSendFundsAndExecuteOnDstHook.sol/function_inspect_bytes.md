# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/bridges/across/ApproveAndAcrossSendFundsAndExecuteOnDstHook.sol/contract_ApproveAndAcrossSendFundsAndExecuteOnDstHook.md]

## Metadata

- **Contract**: ApproveAndAcrossSendFundsAndExecuteOnDstHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 8697:365:367

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    return abi.encodePacked(BytesLib.toAddress(data, 32), BytesLib.toAddress(data, 52), BytesLib.toAddress(data, 72), BytesLib.toAddress(data, 188));
}
```

## Related Implementations

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
┌─ [0] ⚙️ FUNCTION: ApproveAndAcrossSendFundsAndExecuteOnDstHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 1)
  │   💬 Args: [data, 32]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
  │   💬 Args: [data, 52]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
  │   💬 Args: [data, 72]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
      💬 Args: [data, 188]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
