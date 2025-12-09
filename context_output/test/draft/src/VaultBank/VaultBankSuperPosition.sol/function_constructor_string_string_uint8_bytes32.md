# Function: constructor(string,string,uint8,bytes32)

**Contract**: [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]

## Metadata

- **Contract**: VaultBankSuperPosition
- **Signature**: `constructor(string,string,uint8,bytes32)`
- **Visibility**: public
- **Source Range**: 729:433:555

## Implementation

```solidity
/// @dev `msg.sender` is VaultBank
constructor(string memory name, string memory symbol, uint8 decimals_, bytes32 yieldSourceOracleId_) ERC20(name,symbol) Ownable(msg.sender) {
    if (decimals_ == 0) revert INVALID_DECIMALS();
    if (yieldSourceOracleId_ == bytes32(0)) revert INVALID_YIELD_SOURCE_ORACLE_ID();
    _decimals = decimals_;
    yieldSourceOracleId = yieldSourceOracleId_;
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

### (string,string)

- **Kind**: internal
- **Source**: 1582:113:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  Both values are immutable: they can only be set once during construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **_decimals** (`uint8`)
- **yieldSourceOracleId** (`bytes32`)
- **_pendingOwner** (`address`)
- **_owner** (`address`)
- **_name** (`string`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: VaultBankSuperPosition.constructor(string,string,uint8,bytes32) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: VaultBankSuperPosition
  ├─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   🏗️  Contract: Ownable
  │ └─ [2] ⚙️ FUNCTION: Ownable2Step._transferOwnership(address) (NodeID: 2)
  │     💬 Args: [initialOwner]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 3)
  │       💬 Args: [newOwner]
  │       👁️  Def: internal
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 4)
      💬 Args: [name, symbol]
      🏗️  Contract: ERC20
```

## Documentation

### Function Documentation

@dev `msg.sender` is VaultBank
