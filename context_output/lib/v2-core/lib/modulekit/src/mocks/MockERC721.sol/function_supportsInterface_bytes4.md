# Function: supportsInterface(bytes4)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 5589:332:197

## Implementation

```solidity
function supportsInterface(bytes4 interfaceId) virtual override public view returns (bool) {
    return ((interfaceId == 0x01ffc9a7) || (interfaceId == 0x80ac58cd)) || (interfaceId == 0x5b5e139f);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.supportsInterface(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Query if a contract implements an interface
 @param interfaceID The interface identifier, as specified in ERC-165
 @dev Interface identification is specified in ERC-165. This function
 uses less than 30,000 gas.
 @return `true` if the contract implements `interfaceID` and
 `interfaceID` is not 0xffffffff, `false` otherwise
