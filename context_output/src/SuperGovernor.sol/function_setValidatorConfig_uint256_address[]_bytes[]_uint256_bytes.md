# Function: setValidatorConfig(uint256,address[],bytes[],uint256,bytes)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `setValidatorConfig(uint256,address[],bytes[],uint256,bytes)`
- **Visibility**: external
- **Source Range**: 17191:1509:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
function setValidatorConfig(uint256 version, address[] calldata validators, bytes[] calldata validatorPublicKeys, uint256 quorum, bytes calldata offchainConfig) external onlyRole(_GOVERNOR_ROLE) {
    uint256 validatorsLength = validators.length;
    uint256 validatorPublicKeysLength = validatorPublicKeys.length;
    if (validatorsLength == 0) revert EMPTY_VALIDATOR_ARRAY();
    if (validatorsLength != validatorPublicKeysLength) revert ARRAY_LENGTH_MISMATCH();
    if ((quorum == 0) || (quorum > validatorsLength)) revert INVALID_QUORUM();
    _validatorConfig.validators.clear();
    for (uint256 i; i < validatorsLength; i++) {
        if (validators[i] == address(0)) revert INVALID_ADDRESS();
        if (!_validatorConfig.validators.add(validators[i])) revert VALIDATOR_ALREADY_REGISTERED();
    }
    _validatorConfig.version = version;
    _validatorConfig.quorum = quorum;
    delete _validatorConfig.validatorPublicKeys;
    for (uint256 i; i < validatorPublicKeysLength; i++) {
        _validatorConfig.validatorPublicKeys.push(validatorPublicKeys[i]);
    }
    emit ValidatorConfigSet(_validatorConfig.version, validators, validatorPublicKeys, quorum, offchainConfig);
}
```

## Related Implementations

### clear(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 12206:83:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:clear(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Removes all the values from a set. O(n).
///  WARNING: Developers should keep in mind that this function has an unbounded cost and using it may render the
///  function uncallable if the set grows to the point where clearing it consumes too much gas to fit in a block.
function clear(AddressSet storage set) internal {
    _clear(set._inner);
}
```

### _clear(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4783:237:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_clear(struct EnumerableSet.Set)`

```solidity
///  @dev Removes all the values from a set. O(n).
///  WARNING: This function has an unbounded cost that scales with set size. Developers should keep in mind that
///  using it may render the function uncallable if the set grows to the point where clearing it consumes too much
///  gas to fit in a block.
function _clear(Set storage set) private {
    uint256 len = _length(set);
    for (uint256 i = 0; i < len; ++i) {
        delete set._positions[set._values[i]];
    }
    Arrays.unsafeSetLength(set._values, 0);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5311:107:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

### unsafeSetLength(bytes32[],uint256)

- **Kind**: internal
- **Source**: 19534:160:275
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Arrays.sol:Arrays:unsafeSetLength(bytes32[],uint256)`

```solidity
///  @dev Helper to set the length of a dynamic array. Directly writing to `.length` is forbidden.
///  WARNING: this does not clear elements if length is reduced, of initialize elements if length is increased.
function unsafeSetLength(bytes32[] storage array, uint256 len) internal {
    assembly ("memory-safe") {
        sstore(array.slot, len)
    }
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11418:150:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2497:406:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._positions[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 5101:129:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
}
```

### onlyRole(bytes32)

- **Kind**: modifier
- **Source**: 2431:76:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:onlyRole(bytes32)`

```solidity
///  @dev Modifier that checks that an account has a specific role. Reverts
///  with an {AccessControlUnauthorizedAccount} error including the required role.
modifier onlyRole(bytes32 role) {
    _checkRole(role);
    _;
}
```

### _checkRole(bytes32)

- **Kind**: internal
- **Source**: 3175:103:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32)`

```solidity
///  @dev Reverts with an {AccessControlUnauthorizedAccount} error if `_msgSender()`
///  is missing `role`. Overriding this function changes the behavior of the {onlyRole} modifier.
function _checkRole(bytes32 role) virtual internal view {
    _checkRole(role, _msgSender());
}
```

### _checkRole(bytes32,address)

- **Kind**: internal
- **Source**: 3408:197:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:_checkRole(bytes32,address)`

```solidity
///  @dev Reverts with an {AccessControlUnauthorizedAccount} error if `account`
///  is missing `role`.
function _checkRole(bytes32 role, address account) virtual internal view {
    if (!hasRole(role, account)) {
        revert AccessControlUnauthorizedAccount(account, role);
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

### hasRole(bytes32,address)

- **Kind**: internal
- **Source**: 2830:136:249
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/AccessControl.sol:AccessControl:hasRole(bytes32,address)`

```solidity
///  @dev Returns `true` if `account` has been granted `role`.
function hasRole(bytes32 role, address account) virtual public view returns (bool) {
    return _roles[role].hasRole[account];
}
```

## State Variable Reads

- **_validatorConfig** (`struct SuperGovernor.ValidatorConfig`)
- **_roles** (`mapping(bytes32 => struct AccessControl.RoleData)`)

## State Variable Writes

- **_validatorConfig** (`struct SuperGovernor.ValidatorConfig`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernor.setValidatorConfig(uint256,address[],bytes[],uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.clear(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_validatorConfig.validators]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._clear(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 3)
  │   │   💬 Args: [set]
  │   │   👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: Arrays.unsafeSetLength(bytes32[],uint256) (NodeID: 4)
  │       💬 Args: [set._values, 0]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
  │   💬 Args: [_validatorConfig.validators, validators[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: AccessControl.onlyRole(bytes32) (NodeID: 8)
      💬 Args: [_GOVERNOR_ROLE]
    └─ [2] ⚙️ FUNCTION: AccessControl._checkRole(bytes32) (NodeID: 9)
        💬 Args: [_GOVERNOR_ROLE]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AccessControl._checkRole(bytes32,address) (NodeID: 10)
          💬 Args: [role, _msgSender()]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Context._msgSender() (NodeID: 12)
        │   💬 Args: [no args]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: AccessControl.hasRole(bytes32,address) (NodeID: 11)
            💬 Args: [role, account]
            👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Sets the validator configuration for the protocol
 @dev This function atomically updates all validator configuration including quorum.
      The entire validator set is replaced (not incrementally updated).
      Version must be managed externally for cross-chain synchronization.
      Quorum updates require providing the full validator list.
 @param version The version number for the configuration (for cross-chain sync)
 @param validators Array of validator addresses
 @param validatorPublicKeys Array of validator public keys for signature verification
 @param quorum The number of validators required for consensus
 @param offchainConfig Offchain configuration data (emitted but not stored)
