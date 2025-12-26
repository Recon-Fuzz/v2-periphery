# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol/contract_Swap1InchHook.md]

## Metadata

- **Contract**: Swap1InchHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 4170:1539:387

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory packed) {
    bytes calldata txData_ = data[73:];
    bytes4 selector = bytes4(txData_[:4]);
    if (selector == I1InchAggregationRouterV6.unoswapTo.selector) {
        (Address to, Address token, , , Address dex) = abi.decode(txData_[4:], (Address, Address, uint256, uint256, Address));
        packed = abi.encodePacked(to.get(), token.get(), dex.get());
    } else if (selector == I1InchAggregationRouterV6.swap.selector) {
        (IAggregationExecutor executor, I1InchAggregationRouterV6.SwapDescription memory desc, ) = abi.decode(txData_[4:], (IAggregationExecutor, I1InchAggregationRouterV6.SwapDescription, bytes));
        packed = abi.encodePacked(address(executor), address(desc.srcToken), address(desc.dstToken), address(desc.srcReceiver), address(desc.dstReceiver));
    } else if (selector == I1InchAggregationRouterV6.clipperSwapTo.selector) {
        (IClipperExchange clipperExchange, address recipient, Address srcToken, IERC20 dstToken, , , , , ) = abi.decode(txData_[4:], (IClipperExchange, address, Address, IERC20, uint256, uint256, uint256, bytes32, bytes32));
        packed = abi.encodePacked(address(clipperExchange), recipient, srcToken.get(), address(dstToken));
    } else {
        revert INVALID_SELECTOR();
    }
}
```

## Related Implementations

### get(Address)

- **Kind**: internal
- **Source**: 852:135:440
- **Link**: `lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol:AddressLib:get(Address)`

```solidity
///  @notice Returns the address representation of a uint256.
///  @param a The uint256 value to convert to an address.
///  @return The address representation of the provided uint256 value.
function get(Address a) internal pure returns (address) {
    return address(uint160(Address.unwrap(a) & _LOW_160_BIT_MASK));
}
```

## State Variable Reads

- **_LOW_160_BIT_MASK** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Swap1InchHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 1)
  │   💬 Args: [to]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 2)
  │   💬 Args: [token]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 3)
  │   💬 Args: [dex]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 4)
      💬 Args: [srcToken]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
