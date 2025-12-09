# Function: setMerkleRoot(bytes32)

**Contract**: [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Metadata

- **Contract**: UpDistributor
- **Signature**: `setMerkleRoot(bytes32)`
- **Visibility**: external
- **Source Range**: 1552:145:551

## Implementation

```solidity
///  @notice Set a new merkle root for the distribution
///  @param _merkleRoot The new merkle root
function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner() {
    merkleRoot = _merkleRoot;
    emit MerkleRootSet(_merkleRoot);
}
```

## Related Implementations

### onlyOwner()

- **Kind**: modifier
- **Source**: 1500:62:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1796:162:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    if (owner() != _msgSender()) {
        revert OwnableUnauthorizedAccount(_msgSender());
    }
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1638:85:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **merkleRoot** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributor.setMerkleRoot(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 3)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 4)
      │   💬 Args: [no args]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 5)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Set a new merkle root for the distribution
 @param _merkleRoot The new merkle root
