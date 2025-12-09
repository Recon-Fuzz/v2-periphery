# Function: constructor(address,address)

**Contract**: [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Metadata

- **Contract**: UpDistributor
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1249:177:551

## Implementation

```solidity
constructor(address _token, address initialOwner) Ownable(initialOwner) {
    if (_token == address(0)) revert INVALID_TOKEN_ADDRESS();
    token = IERC20(_token);
}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 1225:187:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting the address provided by the deployer as the initial owner.
constructor(address initialOwner) {
    if (initialOwner == address(0)) {
        revert OwnableInvalidOwner(address(0));
    }
    _transferOwnership(initialOwner);
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

- **_owner** (`address`)

## State Variable Writes

- **token** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_pendingOwner** (`address`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UpDistributor.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UpDistributor
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
      💬 Args: [initialOwner]
      🏗️  Contract: Ownable
    └─ [2] ⚙️ FUNCTION: Ownable2Step._transferOwnership(address) (NodeID: 2)
        💬 Args: [initialOwner]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 3)
          💬 Args: [newOwner]
          👁️  Def: internal
```
