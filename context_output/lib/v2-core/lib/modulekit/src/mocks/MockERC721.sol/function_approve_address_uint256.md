# Function: approve(address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3221:301:197

## Implementation

```solidity
function approve(address spender, uint256 id) virtual override public payable {
    address owner = _ownerOf[id];
    require((msg.sender == owner) || _isApprovedForAll[owner][msg.sender], "NOT_AUTHORIZED");
    _getApproved[id] = spender;
    emit Approval(owner, spender, id);
}
```

## State Variable Reads

- **_ownerOf** (`mapping(uint256 => address)`)
- **_isApprovedForAll** (`mapping(address => mapping(address => bool))`)

## State Variable Writes

- **_getApproved** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
