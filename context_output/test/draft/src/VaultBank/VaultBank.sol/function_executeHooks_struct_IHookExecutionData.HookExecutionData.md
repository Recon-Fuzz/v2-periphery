# Function: executeHooks(struct IHookExecutionData.HookExecutionData)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `executeHooks(struct IHookExecutionData.HookExecutionData)`
- **Visibility**: external
- **Source Range**: 3874:145:552

## Implementation

```solidity
/// @inheritdoc IVaultBank
function executeHooks(IVaultBank.HookExecutionData calldata executionData) external onlyBankManager() {
    _executeHooks(executionData);
}
```

## Related Implementations

### _executeHooks(struct IHookExecutionData.HookExecutionData)

- **Kind**: internal
- **Source**: 1974:4355:507
- **Link**: `src/Bank.sol:Bank:_executeHooks(struct IHookExecutionData.HookExecutionData)`

```solidity
function _executeHooks(IHookExecutionData.HookExecutionData calldata executionData) virtual internal nonReentrant() {
    uint256 hooksLength = executionData.hooks.length;
    if (hooksLength == 0) revert ZERO_LENGTH_ARRAY();
    if (((hooksLength != executionData.data.length) || (hooksLength != executionData.merkleProofs.length)) || (hooksLength != executionData.expectedAssetsOrSharesOut.length)) {
        revert INVALID_ARRAY_LENGTH();
    }
    address prevHook;
    address hookAddress;
    bytes memory hookData;
    bytes32[] memory merkleProof;
    ISuperHook hook;
    bytes32 merkleRoot;
    Execution[] memory executions;
    Execution memory executionStep;
    bool success;
    uint256 expectedOutput;
    uint256 actualOutput;
    for (uint256 i; i < hooksLength; i++) {
        hookAddress = executionData.hooks[i];
        if (hookAddress == address(0)) revert ZERO_ADDRESS();
        hookData = executionData.data[i];
        merkleProof = executionData.merkleProofs[i];
        expectedOutput = executionData.expectedAssetsOrSharesOut[i];
        hook = ISuperHook(hookAddress);
        if (!_isHookRegistered(hookAddress)) revert HOOK_NOT_REGISTERED();
        merkleRoot = _getMerkleRootForHook(hookAddress);
        if (!_validateHookConfiguration(hookAddress, hookData, merkleProof, merkleRoot)) {
            revert HOOK_VALIDATION_FAILED();
        }
        hook.setExecutionContext(address(this));
        executions = hook.build(prevHook, address(this), hookData);
        uint256 len = executions.length;
        for (uint256 j; j < len; ++j) {
            executionStep = executions[j];
            uint256 valueToSend = executionStep.value;
            address targetToCall = executionStep.target;
            bytes memory callData = executionStep.callData;
            assembly {
                success := call(gas(), targetToCall, valueToSend, add(callData, 0x20), mload(callData), 0, 0)
            }
            if (!success) {
                revert HOOK_EXECUTION_FAILED();
            }
        }
        actualOutput = ISuperHookResult(address(hook)).getOutAmount(address(this));
        if (actualOutput < expectedOutput) {
            revert MINIMUM_OUTPUT_AMOUNT_NOT_MET();
        }
        hook.resetExecutionState(address(this));
        prevHook = hookAddress;
    }
    emit HooksExecuted(executionData.hooks, executionData.data);
}
```

### _isHookRegistered(address)

- **Kind**: internal
- **Source**: 6684:154:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_isHookRegistered(address)`

```solidity
function _isHookRegistered(address hookAddress) override internal view returns (bool) {
    return SUPER_GOVERNOR.isHookRegistered(hookAddress);
}
```

### _getMerkleRootForHook(address)

- **Kind**: internal
- **Source**: 6507:171:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_getMerkleRootForHook(address)`

```solidity
function _getMerkleRootForHook(address hookAddress) override internal view returns (bytes32) {
    return SUPER_REGISTRY.getVaultBankHookMerkleRoot(hookAddress);
}
```

### _validateHookConfiguration(address,bytes,bytes32[],bytes32)

- **Kind**: internal
- **Source**: 6995:1166:507
- **Link**: `src/Bank.sol:Bank:_validateHookConfiguration(address,bytes,bytes32[],bytes32)`

```solidity
/// @notice Validates a hook configuration using Merkle proof.
///  @dev Validates the hook configuration (hook address + arguments from inspect()) instead of individual targets.
///  @param hookAddress Address of the hook contract.
///  @param hookData Calldata to pass to the hook.
///  @param proof Merkle proof for this hook configuration.
///  @param root Merkle root to verify against.
///  @return valid True if the hook configuration is approved.
function _validateHookConfiguration(address hookAddress, bytes memory hookData, bytes32[] memory proof, bytes32 root) private view returns (bool valid) {
    if (root == bytes32(0)) return false;
    bytes memory hookArgs;
    try ISuperHookInspector(hookAddress).inspect(hookData) returns (bytes memory args) {
        hookArgs = args;
    } catch {
        return false;
    }
    if (hookArgs.length == 0) return false;
    bytes32 leaf = _createHookLeaf(hookAddress, hookArgs);
    if (proof.length == 0) {
        return root == leaf;
    }
    return MerkleProof.verify(proof, root, leaf);
}
```

### _createHookLeaf(address,bytes)

- **Kind**: internal
- **Source**: 8500:198:507
- **Link**: `src/Bank.sol:Bank:_createHookLeaf(address,bytes)`

```solidity
/// @notice Creates a Merkle leaf for a hook configuration.
///  @dev Matches StandardMerkleTree.of() leaf hashing: keccak256(bytes.concat(keccak256(abi.encode(...))))
///  @param hookAddress Address of the hook contract.
///  @param hookArgs Encoded arguments from inspect().
///  @return leaf The Merkle leaf hash.
function _createHookLeaf(address hookAddress, bytes memory hookArgs) private pure returns (bytes32 leaf) {
    return keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
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

### nonReentrant()

- **Kind**: modifier
- **Source**: 2466:103:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 2575:307:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    if (_status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    _status = ENTERED;
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 2888:208:282
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol:ReentrancyGuard:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    _status = NOT_ENTERED;
}
```

### onlyBankManager()

- **Kind**: modifier
- **Source**: 2004:210:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:onlyBankManager()`

```solidity
modifier onlyBankManager() {
    if (!IAccessControl(address(SUPER_GOVERNOR)).hasRole(SUPER_GOVERNOR.BANK_MANAGER_ROLE(), msg.sender)) {
        revert INVALID_BANK_MANAGER();
    }
    _;
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **_status** (`uint256`)
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## State Variable Writes

- **_status** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.executeHooks(struct IHookExecutionData.HookExecutionData) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Bank._executeHooks(struct IHookExecutionData.HookExecutionData) (NodeID: 1)
  │   💬 Args: [executionData]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: VaultBank._isHookRegistered(address) (NodeID: 2)
  │ │   💬 Args: [hookAddress]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: VaultBank._getMerkleRootForHook(address) (NodeID: 3)
  │ │   💬 Args: [hookAddress]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Bank._validateHookConfiguration(address,bytes,bytes32[],bytes32) (NodeID: 4)
  │ │   💬 Args: [hookAddress, hookData, merkleProof, merkleRoot]
  │ │   👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: Bank._createHookLeaf(address,bytes) (NodeID: 5)
  │ │ │   💬 Args: [hookAddress, hookArgs]
  │ │ │   👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: MerkleProof.verify(bytes32[],bytes32,bytes32) (NodeID: 6)
  │ │     💬 Args: [proof, root, leaf]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: MerkleProof.processProof(bytes32[],bytes32) (NodeID: 7)
  │ │       💬 Args: [proof, leaf]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Hashes.commutativeKeccak256(bytes32,bytes32) (NodeID: 8)
  │ │         💬 Args: [computedHash, proof[i]]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 9)
  │ │       │   💬 Args: [a, b]
  │ │       │   👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Hashes.efficientKeccak256(bytes32,bytes32) (NodeID: 10)
  │ │           💬 Args: [b, a]
  │ │           👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: ReentrancyGuard.nonReentrant() (NodeID: 11)
  │     💬 Args: [no args]
  │   ├─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantBefore() (NodeID: 12)
  │   │   💬 Args: [no args]
  │   │   👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: ReentrancyGuard._nonReentrantAfter() (NodeID: 13)
  │       💬 Args: [no args]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: VaultBank.onlyBankManager() (NodeID: 14)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Execute hooks
 @dev Used to claim rewards
 @param executionData The execution data
