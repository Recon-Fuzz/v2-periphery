# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/tokens/erc20/ApproveERC20Hook.sol/contract_ApproveERC20Hook.md]

## Metadata

- **Contract**: ApproveERC20Hook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 2856:235:396

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    return abi.encodePacked(BytesLib.toAddress(data, 0), BytesLib.toAddress(data, 20));
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
┌─ [0] ⚙️ FUNCTION: ApproveERC20Hook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 1)
  │   💬 Args: [data, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
      💬 Args: [data, 20]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
