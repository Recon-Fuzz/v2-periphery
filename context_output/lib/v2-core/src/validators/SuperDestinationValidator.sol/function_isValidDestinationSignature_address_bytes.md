# Function: isValidDestinationSignature(address,bytes)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `isValidDestinationSignature(address,bytes)`
- **Visibility**: external
- **Source Range**: 1839:634:437

## Implementation

```solidity
function isValidDestinationSignature(address sender, bytes calldata data) external view returns (bytes4) {
    if (!_initialized[sender]) revert NOT_INITIALIZED();
    (SignatureData memory sigData, DestinationData memory destinationData) = _decodeSignatureAndDestinationData(data);
    (address signer, ) = _createLeafAndVerifyProofAndSignature(sender, sigData, destinationData);
    bool isValid = _isSignatureValid(signer, sender, sigData.validUntil);
    return isValid ? DESTINATION_SIGNATURE_MAGIC_VALUE : bytes4("");
}
```

## Related Implementations

### _decodeSignatureAndDestinationData(bytes)

- **Kind**: internal
- **Source**: 6120:364:437
- **Link**: `lib/v2-core/src/validators/SuperDestinationValidator.sol:SuperDestinationValidator:_decodeSignatureAndDestinationData(bytes)`

```solidity
/// @notice Decodes signature and destination data from raw bytes
///  @dev Decodes the signature data and destination data from the raw bytes
///  @param data Raw bytes containing signature and destination data
///  @return The decoded signature data and destination data
function _decodeSignatureAndDestinationData(bytes memory data) private pure returns (SignatureData memory, DestinationData memory) {
    (bytes memory sigDataRaw, bytes memory destinationDataRaw) = abi.decode(data, (bytes, bytes));
    return (_decodeSignatureData(sigDataRaw), _decodeDestinationData(destinationDataRaw));
}
```

### _decodeSignatureData(bytes)

- **Kind**: internal
- **Source**: 5593:647:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_decodeSignatureData(bytes)`

```solidity
/// @notice Decodes raw signature data into a structured SignatureData object
///  @dev Handles ABI decoding of all signature components
///  @param sigDataRaw ABI-encoded signature data bytes
///  @return Structured SignatureData for further processing
function _decodeSignatureData(bytes memory sigDataRaw) virtual internal pure returns (SignatureData memory) {
    (uint64[] memory chainsWithDestinationExecution, uint48 validUntil, uint48 validAfter, bytes32 merkleRoot, bytes32[] memory proofSrc, DstProof[] memory proofDst, bytes memory signature) = abi.decode(sigDataRaw, (uint64[], uint48, uint48, bytes32, bytes32[], DstProof[], bytes));
    return SignatureData(chainsWithDestinationExecution, validUntil, validAfter, merkleRoot, proofSrc, proofDst, signature);
}
```

### _decodeDestinationData(bytes)

- **Kind**: internal
- **Source**: 6670:543:437
- **Link**: `lib/v2-core/src/validators/SuperDestinationValidator.sol:SuperDestinationValidator:_decodeDestinationData(bytes)`

```solidity
/// @notice Decodes raw destination data
///  @param destinationDataRaw ABI-encoded destination data bytes
///  @return Structured DestinationData for further processing
function _decodeDestinationData(bytes memory destinationDataRaw) private pure returns (DestinationData memory) {
    (bytes memory callData, uint64 chainId, address decodedSender, address executor, address[] memory dstTokens, uint256[] memory intentAmounts) = abi.decode(destinationDataRaw, (bytes, uint64, address, address, address[], uint256[]));
    return DestinationData(callData, chainId, decodedSender, executor, dstTokens, intentAmounts);
}
```

### _createLeafAndVerifyProofAndSignature(address,struct ISuperValidator.SignatureData,struct ISuperValidator.DestinationData)

- **Kind**: internal
- **Source**: 4424:681:437
- **Link**: `lib/v2-core/src/validators/SuperDestinationValidator.sol:SuperDestinationValidator:_createLeafAndVerifyProofAndSignature(address,struct ISuperValidator.SignatureData,struct ISuperValidator.DestinationData)`

```solidity
/// @notice Creates leaf and verifies destination proof and signature
///  @dev Verifies destination data is part of the merkle tree using extracted proof for current chain
///       and processes signature for any account type (EOA, EIP-1271, EIP-7702)
///  @param sender The sender address to validate the signature against
///  @param sigData Signature data including merkle root, proofs, and actual signature
///  @param destinationData The destination execution data to create the leaf hash from
///  @return signer The address that signed the message
///  @return leaf The computed leaf hash used in merkle verification
function _createLeafAndVerifyProofAndSignature(address sender, SignatureData memory sigData, DestinationData memory destinationData) private view returns (address signer, bytes32 leaf) {
    leaf = _createLeafForDestination(abi.encode(destinationData), sigData.validUntil);
    if (!MerkleProof.verify(_extractProof(sigData), sigData.merkleRoot, leaf)) revert INVALID_PROOF();
    signer = _processSignatureForAccountType(sender, sigData);
}
```

### _createLeafForDestination(bytes,uint48)

- **Kind**: internal
- **Source**: 3298:282:437
- **Link**: `lib/v2-core/src/validators/SuperDestinationValidator.sol:SuperDestinationValidator:_createLeafForDestination(bytes,uint48)`

```solidity
/// @notice Creates a unique leaf hash for merkle tree verification
///  @dev Overrides the base implementation to handle destination-specific data
///       `executor` is included in the leaf to ensure that the leaf is unique for each executor,
///       otherwise it would allow the owner's signature to be replayed if the account mistakenly
///       installs two of the same executors
///  @param data Encoded destination data containing execution details
///  @param validUntil Timestamp after which the signature becomes invalid
///  @return The calculated leaf hash used in merkle tree verification
function _createLeafForDestination(bytes memory data, uint48 validUntil) internal view returns (bytes32) {
    DestinationData memory destinationData = abi.decode(data, (DestinationData));
    return _createDestinationLeaf(destinationData, validUntil, address(this));
}
```

### _createDestinationLeaf(struct ISuperValidator.DestinationData,uint48,address)

- **Kind**: internal
- **Source**: 4264:1056:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_createDestinationLeaf(struct ISuperValidator.DestinationData,uint48,address)`

```solidity
function _createDestinationLeaf(DestinationData memory destinationData, uint48 validUntil, address validator) virtual internal view returns (bytes32) {
    return keccak256(bytes.concat(keccak256(abi.encode(destinationData.callData, destinationData.chainId, destinationData.sender, destinationData.executor, destinationData.dstTokens, destinationData.intentAmounts, validUntil, validator))));
}
```

### verify(bytes32[],bytes32,bytes32)

- **Kind**: internal
- **Source**: 1902:154:290
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol:MerkleProof:verify(bytes32[],bytes32,bytes32)`

```solidity
///  @dev Returns true if a `leaf` can be proved to be a part of a Merkle tree
///  defined by `root`. For this, a `proof` must be provided, containing
///  sibling hashes on the branch from the leaf to the root of the tree. Each
///  pair of leaves and each pair of pre-images are assumed to be sorted.
///  This version handles proofs in memory with the default hashing function.
function verify(bytes32[] memory proof, bytes32 root, bytes32 leaf) internal pure returns (bool) {
    return processProof(proof, leaf) == root;
}
```

### _extractProof(struct ISuperValidator.SignatureData)

- **Kind**: internal
- **Source**: 5498:330:437
- **Link**: `lib/v2-core/src/validators/SuperDestinationValidator.sol:SuperDestinationValidator:_extractProof(struct ISuperValidator.SignatureData)`

```solidity
/// @notice Extracts the proof for the current chain from the signature data
///  @dev Iterates over the proofDst array to find a match for the current chain ID
///  @param sigData Signature data containing proofs for different chains
///  @return The proof array corresponding to the current chain ID
///  @dev Reverts with PROOF_NOT_FOUND if no matching proof is found
function _extractProof(SignatureData memory sigData) private view returns (bytes32[] memory) {
    uint256 len = sigData.proofDst.length;
    for (uint256 i; i < len; ++i) {
        if (sigData.proofDst[i].dstChainId == block.chainid) return sigData.proofDst[i].proof;
    }
    revert PROOF_NOT_FOUND();
}
```

### processProof(bytes32[],bytes32)

- **Kind**: internal
- **Source**: 2457:308:290
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol:MerkleProof:processProof(bytes32[],bytes32)`

```solidity
///  @dev Returns the rebuilt hash obtained by traversing a Merkle tree up
///  from `leaf` using `proof`. A `proof` is valid if and only if the rebuilt
///  hash matches the root of the tree. When processing the proof, the pairs
///  of leaves & pre-images are assumed to be sorted.
///  This version handles proofs in memory with the default hashing function.
function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
    bytes32 computedHash = leaf;
    for (uint256 i = 0; i < proof.length; i++) {
        computedHash = Hashes.commutativeKeccak256(computedHash, proof[i]);
    }
    return computedHash;
}
```

### commutativeKeccak256(bytes32,bytes32)

- **Kind**: internal
- **Source**: 504:167:289
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/Hashes.sol:Hashes:commutativeKeccak256(bytes32,bytes32)`

```solidity
///  @dev Commutative Keccak256 hash of a sorted pair of bytes32. Frequently used when working with merkle proofs.
///  NOTE: Equivalent to the `standardNodeHash` in our https://github.com/OpenZeppelin/merkle-tree[JavaScript library].
function commutativeKeccak256(bytes32 a, bytes32 b) internal pure returns (bytes32) {
    return (a < b) ? efficientKeccak256(a, b) : efficientKeccak256(b, a);
}
```

### efficientKeccak256(bytes32,bytes32)

- **Kind**: internal
- **Source**: 791:239:289
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/Hashes.sol:Hashes:efficientKeccak256(bytes32,bytes32)`

```solidity
///  @dev Implementation of keccak256(abi.encode(a, b)) that doesn't allocate or expand memory.
function efficientKeccak256(bytes32 a, bytes32 b) internal pure returns (bytes32 value) {
    assembly ("memory-safe") {
        mstore(0x00, a)
        mstore(0x20, b)
        value := keccak256(0x00, 0x40)
    }
}
```

### _processSignatureForAccountType(address,struct ISuperValidator.SignatureData)

- **Kind**: internal
- **Source**: 6748:1579:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_processSignatureForAccountType(address,struct ISuperValidator.SignatureData)`

```solidity
/// @notice Processes signature for any account type after merkle proof verification
///  @dev Common method that handles signature processing for EOA, EIP-1271 smart contracts, and EIP-7702 accounts
///       This method assumes merkle proof has already been verified by the caller
///  @param sender The account address being operated on
///  @param sigData Signature data including merkle root, proofs, and actual signature
///  @return signer The address that signed the message
function _processSignatureForAccountType(address sender, SignatureData memory sigData) internal view returns (address signer) {
    /// @dev For EIP-7702 accounts, the signer is the account itself (EOA with delegated code)
    if (_is7702Account(sender.code)) {
        signer = _processECDSASignature(sigData);
    } else {
        address owner = _accountOwners[sender];
        /// @dev Check if owner is an EOA (no code) or owner is EIP-7702 (delegated EOA) - should be treated as EOA
        if ((owner.code.length == 0) || _is7702Account(owner.code)) {
            return _processECDSASignature(sigData);
        }
        bytes32 messageHash = _createMessageHash(sigData.merkleRoot);
        /// @dev At this point, we know owner is a smart contract (not EOA, not EIP-7702)
        ///  Only two options left: Safe or EIP-1271-compatible contract
        ///  @dev First tries Safe-specific chain-agnostic validation, then falls back to generic EIP-1271
        if (owner.validateChainAgnosticMultisig(sigData, messageHash)) {
            return owner;
        }
        try IERC1271(owner).isValidSignature(messageHash, sigData.signature) returns (bytes4 result) {
            if (result == EIP1271_MAGIC_VALUE) {
                return owner;
            }
        } catch {}
        revert NOT_EIP1271_SIGNER();
    }
}
```

### _is7702Account(bytes)

- **Kind**: internal
- **Source**: 11739:126:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_is7702Account(bytes)`

```solidity
/// @notice Checks if an address is a 7702 signer
///  @param code The code of the address to check
///  @return True if the address is a 7702 signer, false otherwise
function _is7702Account(bytes memory code) internal pure returns (bool) {
    return bytes3(code) == EIP7702_PREFIX;
}
```

### _processECDSASignature(struct ISuperValidator.SignatureData)

- **Kind**: internal
- **Source**: 8548:345:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_processECDSASignature(struct ISuperValidator.SignatureData)`

```solidity
/// @notice Processes an EOA signature and returns the signer
///  @param sigData Signature data including merkle root, proofs, and actual signature
///  @return signer The address that signed the message
function _processECDSASignature(SignatureData memory sigData) internal pure returns (address signer) {
    bytes32 messageHash = _createMessageHash(sigData.merkleRoot);
    bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);
    signer = ECDSA.recover(ethSignedMessageHash, sigData.signature);
}
```

### _createMessageHash(bytes32)

- **Kind**: internal
- **Source**: 9290:150:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_createMessageHash(bytes32)`

```solidity
/// @notice Creates a message hash from a merkle root for signature verification
///  @dev In the base implementation, the message hash is simply the merkle root itself
///       Derived contracts might implement more complex hashing if needed
///  @param merkleRoot The merkle root to use for message hash creation
///  @return The hash that was signed by the account owner
function _createMessageHash(bytes32 merkleRoot) internal pure returns (bytes32) {
    return keccak256(abi.encode(namespace(), merkleRoot));
}
```

### namespace()

- **Kind**: internal
- **Source**: 2581:93:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:namespace()`

```solidity
function namespace() public pure returns (string memory) {
    return _namespace();
}
```

### _namespace()

- **Kind**: internal
- **Source**: 4150:108:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_namespace()`

```solidity
/// @notice Returns the namespace identifier for this validator
///  @dev Used for module compatibility and identification in the ERC-7579 framework
///  @return The string identifier for this validator class
function _namespace() virtual internal pure returns (string memory) {
    return "SuperValidator";
}
```

### toEthSignedMessageHash(bytes32)

- **Kind**: internal
- **Source**: 1247:433:291
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toEthSignedMessageHash(bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an ERC-191 signed data with version
///  `0x45` (`personal_sign` messages).
///  The digest is calculated by prefixing a bytes32 `messageHash` with
///  `"\x19Ethereum Signed Message:\n32"` and hashing the result. It corresponds with the
///  hash signed when using the https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign[`eth_sign`] JSON-RPC method.
///  NOTE: The `messageHash` parameter is intended to be the result of hashing a raw message with
///  keccak256, although any bytes32 value can be safely used because the final digest will
///  be re-hashed.
///  See {ECDSA-recover}.
function toEthSignedMessageHash(bytes32 messageHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        mstore(0x00, "\u0019Ethereum Signed Message:\n32")
        mstore(0x1c, messageHash)
        digest := keccak256(0x00, 0x3c)
    }
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

### _isSignatureValid(address,address,uint48)

- **Kind**: internal
- **Source**: 11303:253:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_isSignatureValid(address,address,uint48)`

```solidity
/// @notice Validates if a signature is valid based on signer and expiration time
///  @dev Checks that the signer matches the registered account owner and signature hasn't expired
///  @param signer The address recovered from the signature
///  @param sender The account address being operated on
///  @param validUntil Timestamp after which the signature is no longer valid
///  @return True if the signature is valid, false otherwise
function _isSignatureValid(address signer, address sender, uint48 validUntil) virtual internal view returns (bool) {
    return _isSignatureValid(signer, sender, validUntil, 0);
}
```

### _isSignatureValid(address,address,uint48,uint48)

- **Kind**: internal
- **Source**: 9982:859:439
- **Link**: `lib/v2-core/src/validators/SuperValidatorBase.sol:SuperValidatorBase:_isSignatureValid(address,address,uint48,uint48)`

```solidity
/// @notice Validates if a signature is valid based on signer and expiration time
///  @dev Checks that the signer matches the registered account owner and signature hasn't expired
///  @param signer The address recovered from the signature
///  @param sender The account address being operated on
///  @param validUntil Timestamp after which the signature is no longer valid
///  @param validAfter Timestamp before which the signature is not yet valid
///  @return True if the signature is valid, false otherwise
function _isSignatureValid(address signer, address sender, uint48 validUntil, uint48 validAfter) virtual internal view returns (bool) {
    /// @dev block.timestamp could vary between chains
    bool isValid = (block.timestamp >= validAfter) && ((validUntil == 0) || ((validUntil >= block.timestamp) && (validAfter <= validUntil)));
    if (_is7702Account(sender.code)) {
        return (signer == sender) && isValid;
    }
    return (signer == _accountOwners[sender]) && isValid;
}
```

## State Variable Reads

- **DESTINATION_SIGNATURE_MAGIC_VALUE** (`bytes4`)
- **_accountOwners** (`mapping(address => address)`)
- **EIP1271_MAGIC_VALUE** (`bytes4`)
- **EIP7702_PREFIX** (`bytes3`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperDestinationValidator.isValidDestinationSignature(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperDestinationValidator._decodeSignatureAndDestinationData(bytes) (NodeID: 1)
  │   💬 Args: [data]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: SuperValidatorBase._decodeSignatureData(bytes) (NodeID: 2)
  │ │   💬 Args: [sigDataRaw]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperDestinationValidator._decodeDestinationData(bytes) (NodeID: 3)
  │     💬 Args: [destinationDataRaw]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperDestinationValidator._createLeafAndVerifyProofAndSignature(address,struct ISuperValidator.SignatureData,struct ISuperValidator.DestinationData) (NodeID: 4)
  │   💬 Args: [sender, sigData, destinationData]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: SuperDestinationValidator._createLeafForDestination(bytes,uint48) (NodeID: 5)
  │ │   💬 Args: [abi.encode(destinationData), sigData.validUntil]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SuperValidatorBase._createDestinationLeaf(struct ISuperValidator.DestinationData,uint48,address) (NodeID: 6)
  │ │     💬 Args: [destinationData, validUntil, address(this)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleProof.verify(bytes32[],bytes32,bytes32) (NodeID: 7)
  │ │   💬 Args: [_extractProof(sigData), sigData.merkleRoot, leaf]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SuperDestinationValidator._extractProof(struct ISuperValidator.SignatureData) (NodeID: 12)
  │ │ │   💬 Args: [sigData]
  │ │ │   👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: MerkleProof.processProof(bytes32[],bytes32) (NodeID: 8)
  │ │     💬 Args: [proof, leaf]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Hashes.commutativeKeccak256(bytes32,bytes32) (NodeID: 9)
  │ │       💬 Args: [computedHash, proof[i]]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 10)
  │ │     │   💬 Args: [a, b]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 11)
  │ │         💬 Args: [b, a]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperValidatorBase._processSignatureForAccountType(address,struct ISuperValidator.SignatureData) (NodeID: 13)
  │     💬 Args: [sender, sigData]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperValidatorBase._is7702Account(bytes) (NodeID: 14)
  │   │   💬 Args: [sender.code]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperValidatorBase._processECDSASignature(struct ISuperValidator.SignatureData) (NodeID: 15)
  │   │   💬 Args: [sigData]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SuperValidatorBase._createMessageHash(bytes32) (NodeID: 16)
  │   │ │   💬 Args: [sigData.merkleRoot]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: SuperValidatorBase.namespace() (NodeID: 17)
  │   │ │     💬 Args: [no args]
  │   │ │     👁️  Def: public
  │   │ │   └─ [6] ⚙️ FUNCTION: SuperValidatorBase._namespace() (NodeID: 18)
  │   │ │       💬 Args: [no args]
  │   │ │       👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: MessageHashUtils.toEthSignedMessageHash(bytes32) (NodeID: 19)
  │   │ │   💬 Args: [messageHash]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 20)
  │   │     💬 Args: [ethSignedMessageHash, sigData.signature]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 21)
  │   │   │   💬 Args: [hash, signature]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 22)
  │   │   │     💬 Args: [hash, v, r, s]
  │   │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 23)
  │   │       💬 Args: [error, errorArg]
  │   │       👁️  Def: private
  │   ├─ [3] ⚙️ FUNCTION: SuperValidatorBase._is7702Account(bytes) (NodeID: 24)
  │   │   💬 Args: [owner.code]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperValidatorBase._processECDSASignature(struct ISuperValidator.SignatureData) (NodeID: 25)
  │   │   💬 Args: [sigData]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SuperValidatorBase._createMessageHash(bytes32) (NodeID: 26)
  │   │ │   💬 Args: [sigData.merkleRoot]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: SuperValidatorBase.namespace() (NodeID: 27)
  │   │ │     💬 Args: [no args]
  │   │ │     👁️  Def: public
  │   │ │   └─ [6] ⚙️ FUNCTION: SuperValidatorBase._namespace() (NodeID: 28)
  │   │ │       💬 Args: [no args]
  │   │ │       👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: MessageHashUtils.toEthSignedMessageHash(bytes32) (NodeID: 29)
  │   │ │   💬 Args: [messageHash]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ECDSA.recover(bytes32,bytes) (NodeID: 30)
  │   │     💬 Args: [ethSignedMessageHash, sigData.signature]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,bytes) (NodeID: 31)
  │   │   │   💬 Args: [hash, signature]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: ECDSA.tryRecover(bytes32,uint8,bytes32,bytes32) (NodeID: 32)
  │   │   │     💬 Args: [hash, v, r, s]
  │   │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: ECDSA._throwError(enum ECDSA.RecoverError,bytes32) (NodeID: 33)
  │   │       💬 Args: [error, errorArg]
  │   │       👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: SuperValidatorBase._createMessageHash(bytes32) (NodeID: 34)
  │       💬 Args: [sigData.merkleRoot]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SuperValidatorBase.namespace() (NodeID: 35)
  │         💬 Args: [no args]
  │         👁️  Def: public
  │       └─ [5] ⚙️ FUNCTION: SuperValidatorBase._namespace() (NodeID: 36)
  │           💬 Args: [no args]
  │           👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperValidatorBase._isSignatureValid(address,address,uint48) (NodeID: 37)
      💬 Args: [signer, sender, sigData.validUntil]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperValidatorBase._isSignatureValid(address,address,uint48,uint48) (NodeID: 38)
        💬 Args: [signer, sender, validUntil, 0]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SuperValidatorBase._is7702Account(bytes) (NodeID: 39)
          💬 Args: [sender.code]
          👁️  Def: internal
```
