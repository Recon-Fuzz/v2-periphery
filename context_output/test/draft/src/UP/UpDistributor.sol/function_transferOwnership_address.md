# Function: transferOwnership(address)

**Contract**: [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Metadata

- **Contract**: UpDistributor
- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2543:215:251
- **Inherited From**: Ownable

## Implementation

```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner() {
    if (newOwner == address(0)) {
        revert OwnableInvalidOwner(address(0));
    }
    _transferOwnership(newOwner);
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 @dev Transfers ownership of the contract to a new account (`newOwner`).
 Can only be called by the current owner.
