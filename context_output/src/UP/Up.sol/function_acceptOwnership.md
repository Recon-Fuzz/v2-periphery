# Function: acceptOwnership()

**Contract**: [src/UP/Up.sol/contract_Up.md]

## Metadata

- **Contract**: Up
- **Signature**: `acceptOwnership()`
- **Visibility**: public
- **Source Range**: 2244:229:252
- **Inherited From**: Ownable2Step

## Implementation

```solidity
///  @dev The new owner accepts the ownership transfer.
function acceptOwnership() virtual public {
    address sender = _msgSender();
    if (pendingOwner() != sender) {
        revert OwnableUnauthorizedAccount(sender);
    }
    _transferOwnership(sender);
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### pendingOwner()

- **Kind**: internal
- **Source**: 1232:99:252
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable2Step.sol:Ownable2Step:pendingOwner()`

```solidity
///  @dev Returns the address of the pending owner.
function pendingOwner() virtual public view returns (address) {
    return _pendingOwner;
}
```

### _transferOwnership(address)

- **Kind**: internal
- **Source**: 2011:153:252
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable2Step.sol:Ownable2Step:_transferOwnership(address)`

```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`) and deletes any pending owner.
///  Internal function without access restriction.
function _transferOwnership(address newOwner) virtual override internal {
    delete _pendingOwner;
    super._transferOwnership(newOwner);
}
```

### _transferOwnership(address)

- **Kind**: internal
- **Source**: 2912:187:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_transferOwnership(address)`

```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Internal function without access restriction.
function _transferOwnership(address newOwner) virtual internal {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
}
```

## State Variable Reads

- **_pendingOwner** (`address`)
- **_owner** (`address`)

## State Variable Writes

- **_pendingOwner** (`address`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Ownable2Step.acceptOwnership() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Ownable2Step.pendingOwner() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Ownable2Step._transferOwnership(address) (NodeID: 3)
      💬 Args: [sender]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 4)
        💬 Args: [newOwner]
        👁️  Def: internal
```

## Documentation

### Function Documentation

 @dev The new owner accepts the ownership transfer.
