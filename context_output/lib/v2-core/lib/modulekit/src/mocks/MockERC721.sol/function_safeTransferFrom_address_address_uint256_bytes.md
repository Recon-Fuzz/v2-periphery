# Function: safeTransferFrom(address,address,uint256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `safeTransferFrom(address,address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 4920:481:197

## Implementation

```solidity
function safeTransferFrom(address from, address to, uint256 id, bytes memory data) virtual override public payable {
    transferFrom(from, to, id);
    require((!_isContract(to)) || (IERC721TokenReceiver(to).onERC721Received(msg.sender, from, id, data) == IERC721TokenReceiver.onERC721Received.selector), "UNSAFE_RECIPIENT");
}
```

## Related Implementations

### transferFrom(address,address,uint256)

- **Kind**: internal
- **Source**: 3747:709:197
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol:MockERC721:transferFrom(address,address,uint256)`

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

### _isContract(address)

- **Kind**: internal
- **Source**: 7834:278:197
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol:MockERC721:_isContract(address)`

```solidity
function _isContract(address _addr) private view returns (bool) {
    uint256 codeLength;
    assembly {
        codeLength := extcodesize(_addr)
    }
    return codeLength > 0;
}
```

## External Calls

- **IERC721TokenReceiver::onERC721Received(address,address,uint256,bytes memory)**

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
┌─ [0] ⚙️ FUNCTION: MockERC721.safeTransferFrom(address,address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC721.transferFrom(address,address,uint256) (NodeID: 1)
  │   💬 Args: [from, to, id]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MockERC721._isContract(address) (NodeID: 2)
      💬 Args: [to]
      👁️  Def: private
```
