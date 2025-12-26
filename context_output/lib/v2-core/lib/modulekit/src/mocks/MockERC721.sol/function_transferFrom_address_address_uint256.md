# Function: transferFrom(address,address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3747:709:197

## Implementation

```solidity
function transferFrom(address from, address to, uint256 id) virtual override public payable {
    require(from == _ownerOf[id], "WRONG_FROM");
    require(to != address(0), "INVALID_RECIPIENT");
    require(((msg.sender == from) || _isApprovedForAll[from][msg.sender]) || (msg.sender == _getApproved[id]), "NOT_AUTHORIZED");
    _balanceOf[from]--;
    _balanceOf[to]++;
    _ownerOf[id] = to;
    delete _getApproved[id];
    emit Transfer(from, to, id);
}
```

## State Variable Reads

- **_ownerOf** (`mapping(uint256 => address)`)
- **_isApprovedForAll** (`mapping(address => mapping(address => bool))`)
- **_getApproved** (`mapping(uint256 => address)`)

## State Variable Writes

- **_balanceOf** (`mapping(address => uint256)`)
- **_ownerOf** (`mapping(uint256 => address)`)
- **_getApproved** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
