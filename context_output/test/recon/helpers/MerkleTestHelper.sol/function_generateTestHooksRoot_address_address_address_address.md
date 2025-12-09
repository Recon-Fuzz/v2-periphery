# Function: generateTestHooksRoot(address,address,address,address)

**Contract**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

## Metadata

- **Contract**: MerkleTestHelper
- **Signature**: `generateTestHooksRoot(address,address,address,address)`
- **Visibility**: public
- **Source Range**: 751:2370:633

## Implementation

```solidity
/// @notice Generate a test Merkle root for ERC4626 deposit and redeem hooks
///  @param depositHook Address of the Deposit4626VaultHook or ApproveAndDeposit4626VaultHook contract
///  @param redeemHook Address of the Redeem4626VaultHook contract
///  @param mockVault Address of the mock ERC4626 vault
///  @return root The Merkle root for the tree
///  @return proofs Array of proofs for each leaf [depositProof, redeemProof]
function generateTestHooksRoot(address depositHook, address redeemHook, address mockVault, address) public pure returns (bytes32 root, bytes32[][] memory proofs) {
    bytes32[] memory leaves = new bytes32[](2);
    bytes memory depositArgs = abi.encodePacked(mockVault);
    leaves[0] = keccak256(bytes.concat(keccak256(abi.encode(depositHook, depositArgs))));
    bytes memory redeemArgs = abi.encodePacked(mockVault);
    leaves[1] = keccak256(bytes.concat(keccak256(abi.encode(redeemHook, redeemArgs))));
    if (leaves[0] > leaves[1]) {
        (leaves[0], leaves[1]) = (leaves[1], leaves[0]);
    }
    root = keccak256(abi.encodePacked(leaves[0], leaves[1]));
    bytes32 depositLeaf = keccak256(bytes.concat(keccak256(abi.encode(depositHook, depositArgs))));
    proofs = new bytes32[][](2);
    proofs[0] = new bytes32[](1);
    proofs[1] = new bytes32[](1);
    if (leaves[0] == depositLeaf) {
        proofs[0][0] = leaves[1];
        proofs[1][0] = leaves[0];
    } else {
        proofs[0][0] = leaves[1];
        proofs[1][0] = leaves[0];
    }
    return (root, proofs);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerkleTestHelper.generateTestHooksRoot(address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Generate a test Merkle root for ERC4626 deposit and redeem hooks
 @param depositHook Address of the Deposit4626VaultHook or ApproveAndDeposit4626VaultHook contract
 @param redeemHook Address of the Redeem4626VaultHook contract
 @param mockVault Address of the mock ERC4626 vault
 @return root The Merkle root for the tree
 @return proofs Array of proofs for each leaf [depositProof, redeemProof]
