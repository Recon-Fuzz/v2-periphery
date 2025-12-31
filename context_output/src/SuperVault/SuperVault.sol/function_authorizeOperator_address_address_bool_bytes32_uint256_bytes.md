# Function: authorizeOperator(address,address,bool,bytes32,uint256,bytes)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 11370:914:510

## Implementation

```solidity
/// @inheritdoc IERC7741
function authorizeOperator(address controller, address operator, bool approved, bytes32 nonce, uint256 deadline, bytes memory signature) external returns (bool) {
    if (controller == operator) revert UNAUTHORIZED();
    if (block.timestamp > deadline) revert DEADLINE_PASSED();
    if (_authorizations[controller][nonce]) revert UNAUTHORIZED();
    _authorizations[controller][nonce] = true;
    bytes32 structHash = keccak256(abi.encode(AUTHORIZE_OPERATOR_TYPEHASH, controller, operator, approved, nonce, deadline));
    bytes32 digest = _hashTypedDataV4(structHash);
    if (!_isValidSignature(controller, digest, signature)) revert INVALID_SIGNATURE();
    isOperator[controller][operator] = approved;
    emit OperatorSet(controller, operator, approved);
    return true;
}
```

## Related Implementations

### _hashTypedDataV4(bytes32)

- **Kind**: internal
- **Source**: 4832:176:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_hashTypedDataV4(bytes32)`

```solidity
///  @dev Given an already https://eips.ethereum.org/EIPS/eip-712#definition-of-hashstruct[hashed struct], this
///  function returns the hash of the fully encoded EIP712 message for this domain.
///  This hash can be used together with {ECDSA-recover} to obtain the signer of a message. For example:
///  ```solidity
///  bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
///      keccak256("Mail(address to,string contents)"),
///      mailTo,
///      keccak256(bytes(mailContents))
///  )));
///  address signer = ECDSA.recover(digest, signature);
///  ```
function _hashTypedDataV4(bytes32 structHash) virtual internal view returns (bytes32) {
    return MessageHashUtils.toTypedDataHash(_domainSeparatorV4(), structHash);
}
```

### toTypedDataHash(bytes32,bytes32)

- **Kind**: internal
- **Source**: 3874:374:291
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toTypedDataHash(bytes32,bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an EIP-712 typed data (ERC-191 version `0x01`).
///  The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
///  `\x19\x01` and hashing the result. It corresponds to the hash signed by the
///  https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
///  See {ECDSA-recover}.
function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        let ptr := mload(0x40)
        mstore(ptr, "\u0019\u0001")
        mstore(add(ptr, 0x02), domainSeparator)
        mstore(add(ptr, 0x22), structHash)
        digest := keccak256(ptr, 0x42)
    }
}
```

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

### _isValidSignature(address,bytes32,bytes)

- **Kind**: internal
- **Source**: 24366:229:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_isValidSignature(address,bytes32,bytes)`

```solidity
/// @notice Verify an EIP712 signature using OpenZeppelin's ECDSA library
///  @param signer The signer to verify
///  @param digest The digest to verify
///  @param signature The signature to verify
function _isValidSignature(address signer, bytes32 digest, bytes memory signature) internal pure returns (bool) {
    address recoveredSigner = ECDSA.recover(digest, signature);
    return recoveredSigner == signer;
}
```

### recover(bytes32,bytes)

- **Kind**: internal
- **Source**: 3714:255:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:recover(bytes32,bytes)`

```solidity
///  @dev Returns the address that signed a hashed message (`hash`) with
///  `signature`. This address can then be used for verification purposes.
///  The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
///  this function rejects them by requiring the `s` value to be in the lower
///  half order, and the `v` value to be either 27 or 28.
///  IMPORTANT: `hash` _must_ be the result of a hash operation for the
///  verification to be secure: it is possible to craft signatures that
///  recover to arbitrary addresses for non-hashed data. A safe way to ensure
///  this is by receiving a hash of the original message (which may otherwise
///  be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
    (address recovered, RecoverError error, bytes32 errorArg) = tryRecover(hash, signature);
    _throwError(error, errorArg);
    return recovered;
}
```

### tryRecover(bytes32,bytes)

- **Kind**: internal
- **Source**: 2129:778:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:tryRecover(bytes32,bytes)`

```solidity
///  @dev Returns the address that signed a hashed message (`hash`) with `signature` or an error. This will not
///  return address(0) without also returning an error description. Errors are documented using an enum (error type)
///  and a bytes32 providing additional information about the error.
///  If no error is returned, then the address can be used for verification purposes.
///  The `ecrecover` EVM precompile allows for malleable (non-unique) signatures:
///  this function rejects them by requiring the `s` value to be in the lower
///  half order, and the `v` value to be either 27 or 28.
///  IMPORTANT: `hash` _must_ be the result of a hash operation for the
///  verification to be secure: it is possible to craft signatures that
///  recover to arbitrary addresses for non-hashed data. A safe way to ensure
///  this is by receiving a hash of the original message (which may otherwise
///  be too long), and then calling {MessageHashUtils-toEthSignedMessageHash} on it.
///  Documentation for signature generation:
///  - with https://web3js.readthedocs.io/en/v1.3.4/web3-eth-accounts.html#sign[Web3.js]
///  - with https://docs.ethers.io/v5/api/signer/#Signer-signMessage[ethers]
function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address recovered, RecoverError err, bytes32 errArg) {
    if (signature.length == 65) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly ("memory-safe") {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }
        return tryRecover(hash, v, r, s);
    } else {
        return (address(0), RecoverError.InvalidSignatureLength, bytes32(signature.length));
    }
}
```

### tryRecover(bytes32,uint8,bytes32,bytes32)

- **Kind**: internal
- **Source**: 5203:1551:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:tryRecover(bytes32,uint8,bytes32,bytes32)`

```solidity
///  @dev Overload of {ECDSA-tryRecover} that receives the `v`,
///  `r` and `s` signature fields separately.
function tryRecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal pure returns (address recovered, RecoverError err, bytes32 errArg) {
    if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
        return (address(0), RecoverError.InvalidSignatureS, s);
    }
    address signer = ecrecover(hash, v, r, s);
    if (signer == address(0)) {
        return (address(0), RecoverError.InvalidSignature, bytes32(0));
    }
    return (signer, RecoverError.NoError, bytes32(0));
}
```

### _throwError(enum ECDSA.RecoverError,bytes32)

- **Kind**: internal
- **Source**: 7280:532:287
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol:ECDSA:_throwError(enum ECDSA.RecoverError,bytes32)`

```solidity
///  @dev Optionally reverts with the corresponding custom error according to the `error` argument provided.
function _throwError(RecoverError error, bytes32 errorArg) private pure {
    if (error == RecoverError.NoError) {
        return;
    } else if (error == RecoverError.InvalidSignature) {
        revert ECDSAInvalidSignature();
    } else if (error == RecoverError.InvalidSignatureLength) {
        revert ECDSAInvalidSignatureLength(uint256(errorArg));
    } else if (error == RecoverError.InvalidSignatureS) {
        revert ECDSAInvalidSignatureS(errorArg);
    }
}
```

## State Variable Reads

- **_authorizations** (`mapping(address => mapping(bytes32 => bool))`)
- **AUTHORIZE_OPERATOR_TYPEHASH** (`bytes32`)
- **TYPE_HASH** (`bytes32`)

## State Variable Writes

- **_authorizations** (`mapping(address => mapping(bytes32 => bool))`)
- **isOperator** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.authorizeOperator(address,address,bool,bytes32,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EIP712Upgradeable._hashTypedDataV4(bytes32) (NodeID: 1)
  │   💬 Args: [structHash]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 2)
  │     💬 Args: [_domainSeparatorV4(), structHash]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EIP712Upgradeable._domainSeparatorV4() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EIP712Upgradeable._buildDomainSeparator() (NodeID: 4)
  │         💬 Args: [no args]
  │         👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: EIP712Upgradeable._EIP712NameHash() (NodeID: 5)
  │       │   💬 Args: [no args]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 6)
  │       │ │   💬 Args: [no args]
  │       │ │   👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Name() (NodeID: 7)
  │       │     💬 Args: [no args]
  │       │     👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 8)
  │       │       💬 Args: [no args]
  │       │       👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: EIP712Upgradeable._EIP712VersionHash() (NodeID: 9)
  │           💬 Args: [no args]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 10)
  │         │   💬 Args: [no args]
  │         │   👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Version() (NodeID: 11)
  │             💬 Args: [no args]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 12)
  │               💬 Args: [no args]
  │               👁️  Def: private
  └─ [1] ⚙️ FUNCTION: SuperVault._isValidSignature(address,bytes32,bytes) (NodeID: 13)
      💬 Args: [controller, digest, signature]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 14)
        💬 Args: [digest, signature]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 15)
      │   💬 Args: [hash, signature]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 16)
      │     💬 Args: [hash, v, r, s]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 17)
          💬 Args: [error, errorArg]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC7741

### Interface Documentation

 @dev Grants or revokes permissions for `operator` to manage Requests on behalf of the
      `msg.sender`, using an [EIP-712](./eip-712.md) signature.
