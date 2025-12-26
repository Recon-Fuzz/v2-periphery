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
