# Function: setApprovalForAll(address,bool)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `setApprovalForAll(address,bool)`
- **Visibility**: public
- **Source Range**: 3528:213:197

## Implementation

```solidity
function setApprovalForAll(address operator, bool approved) virtual override public {
    _isApprovedForAll[msg.sender][operator] = approved;
    emit ApprovalForAll(msg.sender, operator, approved);
}
```

## State Variable Writes

- **_isApprovedForAll** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.setApprovalForAll(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Enable or disable approval for a third party ("operator") to manage
 all of `msg.sender`'s assets
 @dev Emits the ApprovalForAll event. The contract MUST allow
 multiple operators per owner.
 @param _operator Address to add to the set of authorized operators
 @param _approved True if the operator is approved, false to revoke approval
