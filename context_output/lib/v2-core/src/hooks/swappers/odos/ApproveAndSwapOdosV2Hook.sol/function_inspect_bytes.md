# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/odos/ApproveAndSwapOdosV2Hook.sol/contract_ApproveAndSwapOdosV2Hook.md]

## Metadata

- **Contract**: ApproveAndSwapOdosV2Hook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 4930:523:388

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external view returns (bytes memory) {
    uint256 pathDefinitionLength = BytesLib.toUint256(data, 157);
    address executor = BytesLib.toAddress(data, 189 + pathDefinitionLength);
    return abi.encodePacked(BytesLib.toAddress(data, 0), BytesLib.toAddress(data, 52), BytesLib.toAddress(data, 72), address(ODOS_ROUTER_V2), executor);
}
```

## Related Implementations

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
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

## State Variable Reads

- **ODOS_ROUTER_V2** (`contract IOdosRouterV2`) [lib/v2-core/src/vendor/odos/IOdosRouterV2.sol/interface_IOdosRouterV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ApproveAndSwapOdosV2Hook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 1)
  │   💬 Args: [data, 157]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
  │   💬 Args: [data, 189 + pathDefinitionLength]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
  │   💬 Args: [data, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
  │   💬 Args: [data, 52]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
      💬 Args: [data, 72]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
