# Function: balanceOf(address)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1463:177:197

## Implementation

```solidity
function balanceOf(address owner) virtual override public view returns (uint256) {
    require(owner != address(0), "ZERO_ADDRESS");
    return _balanceOf[owner];
}
```

## State Variable Reads

- **_balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Count all NFTs assigned to an owner
 @dev NFTs assigned to the zero address are considered invalid, and this
 function throws for queries about the zero address.
 @param _owner An address for whom to query the balance
 @return The number of NFTs owned by `_owner`, possibly zero
