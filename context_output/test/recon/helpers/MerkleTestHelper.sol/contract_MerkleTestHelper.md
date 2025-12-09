# Contract: MerkleTestHelper

## Metadata

- **Name**: MerkleTestHelper
- **Type**: Contract
- **Path**: test/recon/helpers/MerkleTestHelper.sol
- **Documentation**: @title MerkleTestHelper
   @notice Helper contract for generating test Merkle roots and proofs for hook validation

## Public/External Functions

### generateTestHooksRoot(address,address,address,address)

- **Signature**: `generateTestHooksRoot(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 751:2370:633
- **Details**: [function_generateTestHooksRoot_address_address_address_address.md](./function_generateTestHooksRoot_address_address_address_address.md)

**Signature:**
```solidity
/// @notice Generate a test Merkle root for ERC4626 deposit and redeem hooks
///  @param depositHook Address of the Deposit4626VaultHook or ApproveAndDeposit4626VaultHook contract
///  @param redeemHook Address of the Redeem4626VaultHook contract
///  @param mockVault Address of the mock ERC4626 vault
///  @return root The Merkle root for the tree
///  @return proofs Array of proofs for each leaf [depositProof, redeemProof]
function generateTestHooksRoot(address depositHook, address redeemHook, address mockVault, address) public pure returns (bytes32 root, bytes32[][] memory proofs);
```

### encodeDepositHookArgs(address,uint256,bool)

- **Signature**: `encodeDepositHookArgs(address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3409:370:633
- **Details**: [function_encodeDepositHookArgs_address_uint256_bool.md](./function_encodeDepositHookArgs_address_uint256_bool.md)

**Signature:**
```solidity
/// @notice Generate encoded hook arguments for Deposit4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param amount Amount to deposit
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeDepositHookArgs(address yieldSource, uint256 amount, bool usePrevHookAmount) public pure returns (bytes memory);
```

### encodeRedeemHookArgs(address,address,uint256,bool)

- **Signature**: `encodeRedeemHookArgs(address,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 4117:447:633
- **Details**: [function_encodeRedeemHookArgs_address_address_uint256_bool.md](./function_encodeRedeemHookArgs_address_address_uint256_bool.md)

**Signature:**
```solidity
/// @notice Generate encoded hook arguments for Redeem4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param owner Address of the owner
///  @param shares Number of shares to redeem
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeRedeemHookArgs(address yieldSource, address owner, uint256 shares, bool usePrevHookAmount) public pure returns (bytes memory);
```

### encodeApproveAndDepositHookArgs(address,address,uint256,bool)

- **Signature**: `encodeApproveAndDepositHookArgs(address,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 4927:458:633
- **Details**: [function_encodeApproveAndDepositHookArgs_address_address_uint256_bool.md](./function_encodeApproveAndDepositHookArgs_address_address_uint256_bool.md)

**Signature:**
```solidity
/// @notice Generate encoded hook arguments for ApproveAndDeposit4626VaultHook
///  @param yieldSource Address of the yield source vault
///  @param token Address of the token to approve and deposit
///  @param amount Amount to deposit
///  @param usePrevHookAmount Whether to use previous hook amount
///  @return Encoded hook arguments
function encodeApproveAndDepositHookArgs(address yieldSource, address token, uint256 amount, bool usePrevHookAmount) public pure returns (bytes memory);
```

### createLeaf(address,bytes)

- **Signature**: `createLeaf(address,bytes)`
- **Visibility**: public
- **Source Range**: 5598:192:633
- **Details**: [function_createLeaf_address_bytes.md](./function_createLeaf_address_bytes.md)

**Signature:**
```solidity
/// @notice Create a leaf hash for a specific hook and arguments
///  @param hookAddress Address of the hook contract
///  @param hookArgs Encoded hook arguments
///  @return leaf The leaf hash
function createLeaf(address hookAddress, bytes memory hookArgs) public pure returns (bytes32 leaf);
```

### verifyProof(bytes32[],bytes32,bytes32)

- **Signature**: `verifyProof(bytes32[],bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 6000:161:633
- **Details**: [function_verifyProof_bytes32[]_bytes32_bytes32.md](./function_verifyProof_bytes32[]_bytes32_bytes32.md)

**Signature:**
```solidity
/// @notice Verify a Merkle proof against a root
///  @param proof Array of proof elements
///  @param root Merkle root
///  @param leaf Leaf to verify
///  @return True if proof is valid
function verifyProof(bytes32[] memory proof, bytes32 root, bytes32 leaf) public pure returns (bool);
```
