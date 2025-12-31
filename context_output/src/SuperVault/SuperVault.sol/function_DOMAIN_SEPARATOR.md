# Function: DOMAIN_SEPARATOR()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 14020:110:510

## Implementation

```solidity
/// @inheritdoc IERC7741
function DOMAIN_SEPARATOR() virtual public view returns (bytes32) {
    return _domainSeparatorV4();
}
```

## Related Implementations

### _domainSeparatorV4()

- **Kind**: internal
- **Source**: 3901:109:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_domainSeparatorV4()`

```solidity
///  @dev Returns the domain separator for the current chain.
function _domainSeparatorV4() internal view returns (bytes32) {
    return _buildDomainSeparator();
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 4016:191:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(TYPE_HASH, _EIP712NameHash(), _EIP712VersionHash(), block.chainid, address(this)));
}
```

### _EIP712NameHash()

- **Kind**: internal
- **Source**: 6928:687:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712NameHash()`

```solidity
///  @dev The hash of the name parameter for the EIP712 domain.
///  NOTE: In previous versions this function was virtual. In this version you should override `_EIP712Name` instead.
function _EIP712NameHash() internal view returns (bytes32) {
    EIP712Storage storage $ = _getEIP712Storage();
    string memory name = _EIP712Name();
    if (bytes(name).length > 0) {
        return keccak256(bytes(name));
    } else {
        bytes32 hashedName = $._hashedName;
        if (hashedName != 0) {
            return hashedName;
        } else {
            return keccak256("");
        }
    }
}
```

### _getEIP712Storage()

- **Kind**: internal
- **Source**: 2606:156:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_getEIP712Storage()`

```solidity
function _getEIP712Storage() private pure returns (EIP712Storage storage $) {
    assembly {
        $.slot := EIP712StorageLocation
    }
}
```

### _EIP712Name()

- **Kind**: internal
- **Source**: 6170:155:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712Name()`

```solidity
///  @dev The name parameter for the EIP712 domain.
///  NOTE: This function reads from storage by default, but can be redefined to return a constant value if gas costs
///  are a concern.
function _EIP712Name() virtual internal view returns (string memory) {
    EIP712Storage storage $ = _getEIP712Storage();
    return $._name;
}
```

### _EIP712VersionHash()

- **Kind**: internal
- **Source**: 7836:723:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712VersionHash()`

```solidity
///  @dev The hash of the version parameter for the EIP712 domain.
///  NOTE: In previous versions this function was virtual. In this version you should override `_EIP712Version` instead.
function _EIP712VersionHash() internal view returns (bytes32) {
    EIP712Storage storage $ = _getEIP712Storage();
    string memory version = _EIP712Version();
    if (bytes(version).length > 0) {
        return keccak256(bytes(version));
    } else {
        bytes32 hashedVersion = $._hashedVersion;
        if (hashedVersion != 0) {
            return hashedVersion;
        } else {
            return keccak256("");
        }
    }
}
```

### _EIP712Version()

- **Kind**: internal
- **Source**: 6552:161:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712Version()`

```solidity
///  @dev The version parameter for the EIP712 domain.
///  NOTE: This function reads from storage by default, but can be redefined to return a constant value if gas costs
///  are a concern.
function _EIP712Version() virtual internal view returns (string memory) {
    EIP712Storage storage $ = _getEIP712Storage();
    return $._version;
}
```

## State Variable Reads

- **TYPE_HASH** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.DOMAIN_SEPARATOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: EIP712Upgradeable._domainSeparatorV4() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EIP712Upgradeable._buildDomainSeparator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: EIP712Upgradeable._EIP712NameHash() (NodeID: 3)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 4)
      │ │   💬 Args: [no args]
      │ │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Name() (NodeID: 5)
      │     💬 Args: [no args]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 6)
      │       💬 Args: [no args]
      │       👁️  Def: private
      └─ [3] ⚙️ FUNCTION: EIP712Upgradeable._EIP712VersionHash() (NodeID: 7)
          💬 Args: [no args]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 8)
        │   💬 Args: [no args]
        │   👁️  Def: private
        └─ [4] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Version() (NodeID: 9)
            💬 Args: [no args]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 10)
              💬 Args: [no args]
              👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC7741

### Interface Documentation

 @dev Returns the `DOMAIN_SEPARATOR` as defined according to EIP-712. The `DOMAIN_SEPARATOR
      should be unique to the contract and chain to prevent replay attacks from other domains,
      and satisfy the requirements of EIP-712, but is otherwise unconstrained.
