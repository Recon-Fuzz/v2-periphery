# Function: getLoanTokenAddress(bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoSupplyAndBorrowHook.sol/contract_MorphoSupplyAndBorrowHook.md]

## Metadata

- **Contract**: MorphoSupplyAndBorrowHook
- **Signature**: `getLoanTokenAddress(bytes)`
- **Visibility**: public
- **Source Range**: 1616:129:375
- **Inherited From**: BaseLoanHook

## Implementation

```solidity
/// @inheritdoc ISuperHookLoans
function getLoanTokenAddress(bytes memory data) public pure returns (address) {
    return BytesLib.toAddress(data, 0);
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
┌─ [0] ⚙️ FUNCTION: BaseLoanHook.getLoanTokenAddress(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 1)
      💬 Args: [data, 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookLoans

### Interface Documentation

@notice Gets the address of the token being borrowed
 @dev Used to identify which asset is being borrowed from the lending protocol
 @param data The hook-specific data containing loan information
 @return The address of the borrowed token
