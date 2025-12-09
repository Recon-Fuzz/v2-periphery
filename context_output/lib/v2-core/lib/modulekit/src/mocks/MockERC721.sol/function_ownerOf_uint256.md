# Function: ownerOf(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `ownerOf(uint256)`
- **Visibility**: public
- **Source Range**: 1299:158:197

## Implementation

```solidity
function ownerOf(uint256 id) virtual override public view returns (address owner) {
    require((owner = _ownerOf[id]) != address(0), "NOT_MINTED");
}
```

## State Variable Reads

- **_ownerOf** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.ownerOf(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Find the owner of an NFT
 @dev NFTs assigned to zero address are considered invalid, and queries
 about them do throw.
 @param _tokenId The identifier for an NFT
 @return The address of the owner of the NFT
