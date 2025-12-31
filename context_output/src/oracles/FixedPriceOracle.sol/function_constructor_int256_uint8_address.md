# Function: constructor(int256,uint8,address)

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `constructor(int256,uint8,address)`
- **Visibility**: public
- **Source Range**: 2250:207:533

## Implementation

```solidity
/// @notice Initializes the oracle with a fixed price and decimals
///  @param initialPrice The initial fixed price (must be > 0)
///  @param decimals_ The number of decimals (typically 8 for USD pairs)
///  @param owner_ The owner who can update the price
constructor(int256 initialPrice, uint8 decimals_, address owner_) Ownable(owner_) {
    if (initialPrice <= 0) revert INVALID_PRICE();
    _answer = initialPrice;
    _decimals = decimals_;
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

- **_answer** (`int256`)
- **_decimals** (`uint8`)
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: FixedPriceOracle.constructor(int256,uint8,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: FixedPriceOracle
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
      💬 Args: [owner_]
      🏗️  Contract: Ownable
    └─ [2] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 2)
        💬 Args: [initialOwner]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Initializes the oracle with a fixed price and decimals
 @param initialPrice The initial fixed price (must be > 0)
 @param decimals_ The number of decimals (typically 8 for USD pairs)
 @param owner_ The owner who can update the price
