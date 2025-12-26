# Function: getApproved(uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `getApproved(uint256)`
- **Visibility**: public
- **Source Range**: 1968:120:197

## Implementation

```solidity
function getApproved(uint256 id) virtual override public view returns (address) {
    return _getApproved[id];
}
```

## State Variable Reads

- **_getApproved** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.getApproved(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
