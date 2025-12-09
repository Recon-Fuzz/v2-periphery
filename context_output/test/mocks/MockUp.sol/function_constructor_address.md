# Function: constructor(address)

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 703:158:606

## Implementation

```solidity
constructor(address initialOwner) ERC20("Superform","UP") ERC20Permit("Superform") Ownable(initialOwner) {
    _mint(initialOwner, INITIAL_SUPPLY);
}
```

## Related Implementations

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7362:208:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
///  @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
///  Relies on the `_update` mechanism
///  Emits a {Transfer} event with `from` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _mint(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(address(0), account, value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 5912:1107:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    if (from == address(0)) {
        _totalSupply += value;
    } else {
        uint256 fromBalance = _balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            _balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            _totalSupply -= value;
        }
    } else {
        unchecked {
            _balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

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

### (string)

- **Kind**: internal
- **Source**: 1577:52:269
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol:ERC20Permit:constructor(string)`

```solidity
///  @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
///  It's a good idea to use the same `name` that is defined as the ERC-20 token name.
constructor(string memory name) EIP712(name,"1") {}
```

### (string,string)

- **Kind**: internal
- **Source**: 3428:431:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:constructor(string,string)`

```solidity
///  @dev Initializes the domain separator and parameter caches.
///  The meaning of `name` and `version` is specified in
///  https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP-712]:
///  - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
///  - `version`: the current major version of the signing domain.
///  NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
///  contract upgrade].
constructor(string memory name, string memory version) {
    _name = name.toShortStringWithFallback(_nameFallback);
    _version = version.toShortStringWithFallback(_versionFallback);
    _hashedName = keccak256(bytes(name));
    _hashedVersion = keccak256(bytes(version));
    _cachedChainId = block.chainid;
    _cachedDomainSeparator = _buildDomainSeparator();
    _cachedThis = address(this);
}
```

### toShortStringWithFallback(string,string)

- **Kind**: internal
- **Source**: 2887:340:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortStringWithFallback(string,string)`

```solidity
///  @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
function toShortStringWithFallback(string memory value, string storage store) internal returns (ShortString) {
    if (bytes(value).length < 32) {
        return toShortString(value);
    } else {
        StorageSlot.getStringSlot(store).value = value;
        return ShortString.wrap(FALLBACK_SENTINEL);
    }
}
```

### toShortString(string)

- **Kind**: internal
- **Source**: 1708:286:283
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortString(string)`

```solidity
///  @dev Encode a string of at most 31 chars into a `ShortString`.
///  This will trigger a `StringTooLong` error is the input string is too long.
function toShortString(string memory str) internal pure returns (ShortString) {
    bytes memory bstr = bytes(str);
    if (bstr.length > 31) {
        revert StringTooLong(str);
    }
    return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
}
```

### getStringSlot(string)

- **Kind**: internal
- **Source**: 3468:175:285
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getStringSlot(string)`

```solidity
///  @dev Returns an `StringSlot` representation of the string storage pointer `store`.
function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
    assembly ("memory-safe") {
        r.slot := store.slot
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 4213:179:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
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

- **INITIAL_SUPPLY** (`uint256`)
- **_balances** (`mapping(address => uint256)`)
- **_owner** (`address`)
- **_nameFallback** (`string`)
- **_versionFallback** (`string`)
- **FALLBACK_SENTINEL** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)
- **_pendingOwner** (`address`)
- **_owner** (`address`)
- **_name** (`ShortString`)
- **_version** (`ShortString`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **_cachedThis** (`address`)
- **_symbol** (`string`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockUp.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockUp
  ├─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 1)
  │   💬 Args: [initialOwner, INITIAL_SUPPLY]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 2)
  │     💬 Args: [address(0), account, value]
  │     👁️  Def: internal
  ├─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 3)
  │   💬 Args: [initialOwner]
  │   🏗️  Contract: Ownable
  │ └─ [2] ⚙️ FUNCTION: Ownable2Step._transferOwnership(address) (NodeID: 4)
  │     💬 Args: [initialOwner]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 5)
  │       💬 Args: [newOwner]
  │       👁️  Def: internal
  ├─ [1] 🏗️ CONSTRUCTOR: ERC20Permit.constructor(string) (NodeID: 6)
  │   💬 Args: ["Superform"]
  │   🏗️  Contract: ERC20Permit
  │ └─ [2] 🏗️ CONSTRUCTOR: EIP712.constructor(string,string) (NodeID: 7)
  │     💬 Args: ["Superform", "1"]
  │     🏗️  Contract: EIP712
  │   ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 8)
  │   │   💬 Args: [name, _nameFallback]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 9)
  │   │ │   💬 Args: [value]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 10)
  │   │     💬 Args: [store]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 11)
  │   │   💬 Args: [version, _versionFallback]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 12)
  │   │ │   💬 Args: [value]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 13)
  │   │     💬 Args: [store]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 14)
  │       💬 Args: [no args]
  │       👁️  Def: private
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 15)
      💬 Args: ["Superform", "UP"]
      🏗️  Contract: ERC20
```
