# Function: validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)

**Contract**: [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Metadata

- **Contract**: ECDSAPPSOracle
- **Signature**: `validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)`
- **Visibility**: public
- **Source Range**: 5796:164:532

## Implementation

```solidity
/// @inheritdoc IECDSAPPSOracle
///  @dev Reverts immediately if duplicate signers are found or quorum is not met
function validateProofs(IECDSAPPSOracle.ValidationParams memory params, uint256 requiredQuorum) public view {
    _validateProofs(params, requiredQuorum);
}
```

## Related Implementations

### _validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)

- **Kind**: internal
- **Source**: 7571:1597:532
- **Link**: `src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle:_validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)`

```solidity
/// @notice Validates an array of proofs for a strategy's PPS update
///  @dev Implements Property 1: Signature Validation & Nonce in Digest (security_properties.md)
///       SECURITY GUARANTEES:
///       1. All signatures are EIP-712 typed structured data
///       2. Each signature includes the current nonce for the strategy (replay protection)
///       3. All signers must be registered validators (checked via SUPER_GOVERNOR)
///       4. All signers must be unique (enforced via ascending order check)
///       5. Quorum requirement must be met (M validators out of N total)
///       SIGNATURE STRUCTURE:
///       digest = EIP-712(strategy, pps, timestamp, noncePerStrategy[strategy])
///       FAILURE MODES:
///       - Reverts if quorum not met (QUORUM_NOT_MET)
///       - Reverts if any signer is not a registered validator (INVALID_VALIDATOR)
///       - Reverts if duplicate signers detected (INVALID_PROOF)
///       - Reverts if signatures in wrong order (INVALID_PROOF)
///  @param params Validation parameters containing strategy, proofs, pps, timestamp
///  @param requiredQuorum Required number of validator signatures (M out of N)
///  @dev Check for this being the active PPS Oracle already done by SuperVaultAggregator
///  @dev Reverts immediately if duplicate signers are found or quorum is not met
function _validateProofs(IECDSAPPSOracle.ValidationParams memory params, uint256 requiredQuorum) internal view {
    uint256 proofsLength = params.proofs.length;
    if (proofsLength == 0) revert ZERO_LENGTH_ARRAY();
    if (proofsLength < requiredQuorum) revert QUORUM_NOT_MET();
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encodePacked(UPDATE_PPS_TYPEHASH, params.strategy, params.pps, params.timestamp, noncePerStrategy[params.strategy])));
    address lastSigner;
    for (uint256 i; i < proofsLength; i++) {
        address signer = ECDSA.recover(digest, params.proofs[i]);
        if (!SUPER_GOVERNOR.isValidator(signer)) revert INVALID_VALIDATOR();
        if (signer <= lastSigner) revert INVALID_PROOF();
        lastSigner = signer;
    }
}
```

### _hashTypedDataV4(bytes32)

- **Kind**: internal
- **Source**: 5017:176:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_hashTypedDataV4(bytes32)`

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
- **Source**: 3945:262:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_domainSeparatorV4()`

```solidity
///  @dev Returns the domain separator for the current chain.
function _domainSeparatorV4() internal view returns (bytes32) {
    if ((address(this) == _cachedThis) && (block.chainid == _cachedChainId)) {
        return _cachedDomainSeparator;
    } else {
        return _buildDomainSeparator();
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

- **UPDATE_PPS_TYPEHASH** (`bytes32`)
- **noncePerStrategy** (`mapping(address => uint256)`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_cachedThis** (`address`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracle.validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracle._validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256) (NodeID: 1)
      💬 Args: [params, requiredQuorum]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EIP712._hashTypedDataV4(bytes32) (NodeID: 2)
    │   💬 Args: [keccak256(abi.encodePacked(UPDATE_PPS_TYPEHASH, params.strategy, params.pps, params.timestamp, noncePerStrategy[params.strategy]))]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 3)
    │     💬 Args: [_domainSeparatorV4(), structHash]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EIP712._domainSeparatorV4() (NodeID: 4)
    │       💬 Args: [no args]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 5)
    │         💬 Args: [no args]
    │         👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 6)
        💬 Args: [digest, params.proofs[i]]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 7)
      │   💬 Args: [hash, signature]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 8)
      │     💬 Args: [hash, v, r, s]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 9)
          💬 Args: [error, errorArg]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IECDSAPPSOracle
 @dev Reverts immediately if duplicate signers are found or quorum is not met

### Interface Documentation

@notice Validates an array of proofs for a strategy's PPS update
 @param params Validation parameters
 @param requiredQuorum Required quorum for validation
