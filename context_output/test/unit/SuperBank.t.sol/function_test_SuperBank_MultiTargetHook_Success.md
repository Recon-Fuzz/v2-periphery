# Function: test_SuperBank_MultiTargetHook_Success()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_MultiTargetHook_Success()`
- **Visibility**: public
- **Source Range**: 61230:3518:658

## Implementation

```solidity
/// @notice THE CRITICAL TEST: Proves the fix for multi-target hook Merkle proof reuse issue
///  @dev This test demonstrates that a single hook can now call multiple external targets
///       OLD SYSTEM: Would fail with INVALID_MERKLE_PROOF because it tried to use one proof for 3 targets
///       NEW SYSTEM: Validates hook configuration once, then executes all targets successfully
function test_SuperBank_MultiTargetHook_Success() public {
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    vm.stopPrank();
    MockERC20 testToken = new MockERC20("Test Token", "TEST", 18);
    address recipient1 = address(0x1001);
    address recipient2 = address(0x1002);
    address recipient3 = address(0x1003);
    uint256 transferAmount = 100e18;
    MockMultiTargetHook multiTargetHook = new MockMultiTargetHook(address(testToken), recipient1, recipient2, recipient3, transferAmount);
    vm.prank(governor);
    superGovernor.registerHook(address(multiTargetHook));
    testToken.mint(address(superBank), transferAmount * 3);
    bytes32 merkleRoot;
    IHookExecutionData.HookExecutionData memory executionData;
    {
        bytes memory hookArgs = abi.encodePacked(address(testToken), recipient1, recipient2, recipient3);
        MerkleTreeBuilder.HookConfig[] memory configs = new MerkleTreeBuilder.HookConfig[](1);
        configs[0] = MerkleTreeBuilder.HookConfig({hookAddress: address(multiTargetHook), encodedArgs: hookArgs});
        merkleRoot = MerkleTreeBuilder.buildTree(configs);
        bytes32[] memory proof = MerkleTreeBuilder.getProof(configs, address(multiTargetHook), hookArgs);
        address[] memory hooks = new address[](1);
        hooks[0] = address(multiTargetHook);
        bytes[] memory data = new bytes[](1);
        data[0] = "";
        bytes32[][] memory merkleProofs = new bytes32[][](1);
        merkleProofs[0] = proof;
        uint256[] memory expectedOutputs = new uint256[](1);
        expectedOutputs[0] = 0;
        executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    }
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getSuperBankHookMerkleRoot(address)", address(multiTargetHook)), abi.encode(merkleRoot));
    superBank.executeHooks(executionData);
    assertEq(testToken.balanceOf(recipient1), transferAmount, "Recipient 1 should receive tokens");
    assertEq(testToken.balanceOf(recipient2), transferAmount, "Recipient 2 should receive tokens");
    assertEq(testToken.balanceOf(recipient3), transferAmount, "Recipient 3 should receive tokens");
    assertEq(testToken.balanceOf(address(superBank)), 0, "SuperBank should have transferred all tokens");
}
```

## Related Implementations

### buildTree(struct MerkleTreeBuilder.HookConfig[])

- **Kind**: internal
- **Source**: 997:550:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:buildTree(struct MerkleTreeBuilder.HookConfig[])`

```solidity
/// @notice Builds a Merkle tree from hook configurations
///  @param configs Array of hook configurations to include in the tree
///  @return root The Merkle root hash
function buildTree(HookConfig[] memory configs) internal pure returns (bytes32 root) {
    if (configs.length == 0) return bytes32(0);
    bytes32[] memory leaves = new bytes32[](configs.length);
    for (uint256 i; i < configs.length; i++) {
        leaves[i] = _createLeaf(configs[i].hookAddress, configs[i].encodedArgs);
    }
    leaves = _sortLeaves(leaves);
    return _buildTreeFromLeaves(leaves);
}
```

### _createLeaf(address,bytes)

- **Kind**: internal
- **Source**: 3328:194:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:_createLeaf(address,bytes)`

```solidity
/// @notice Creates a Merkle leaf for a hook configuration
///  @dev Matches StandardMerkleTree.of() leaf format: keccak256(bytes.concat(keccak256(abi.encode(...))))
///  @param hookAddress Address of the hook contract
///  @param hookArgs Encoded arguments from inspect()
///  @return leaf The Merkle leaf hash
function _createLeaf(address hookAddress, bytes memory hookArgs) private pure returns (bytes32 leaf) {
    return keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
}
```

### _sortLeaves(bytes32[])

- **Kind**: internal
- **Source**: 3668:563:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:_sortLeaves(bytes32[])`

```solidity
/// @notice Sorts an array of bytes32 leaves
///  @param leaves Array of leaf hashes to sort
///  @return sorted The sorted array
function _sortLeaves(bytes32[] memory leaves) private pure returns (bytes32[] memory sorted) {
    sorted = leaves;
    uint256 n = sorted.length;
    for (uint256 i; i < n; i++) {
        for (uint256 j = i + 1; j < n; j++) {
            if (uint256(sorted[i]) > uint256(sorted[j])) {
                bytes32 temp = sorted[i];
                sorted[i] = sorted[j];
                sorted[j] = temp;
            }
        }
    }
    return sorted;
}
```

### _buildTreeFromLeaves(bytes32[])

- **Kind**: internal
- **Source**: 4385:1036:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:_buildTreeFromLeaves(bytes32[])`

```solidity
/// @notice Builds a Merkle tree from sorted leaves
///  @param leaves Array of sorted leaf hashes
///  @return root The Merkle root hash
function _buildTreeFromLeaves(bytes32[] memory leaves) private pure returns (bytes32 root) {
    uint256 n = leaves.length;
    if (n == 1) return leaves[0];
    bytes32[] memory currentLevel = leaves;
    while (currentLevel.length > 1) {
        uint256 nextLevelSize = (currentLevel.length + 1) / 2;
        bytes32[] memory nextLevel = new bytes32[](nextLevelSize);
        for (uint256 i; i < nextLevelSize; i++) {
            uint256 leftIndex = i * 2;
            uint256 rightIndex = leftIndex + 1;
            if (rightIndex < currentLevel.length) {
                nextLevel[i] = _hashPair(currentLevel[leftIndex], currentLevel[rightIndex]);
            } else {
                nextLevel[i] = currentLevel[leftIndex];
            }
        }
        currentLevel = nextLevel;
    }
    return currentLevel[0];
}
```

### _hashPair(bytes32,bytes32)

- **Kind**: internal
- **Source**: 2308:174:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_hashPair(bytes32,bytes32)`

```solidity
function _hashPair(bytes32 a, bytes32 b) internal pure returns (bytes32) {
    return (a < b) ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
}
```

### getProof(struct MerkleTreeBuilder.HookConfig[],address,bytes)

- **Kind**: internal
- **Source**: 1883:928:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:getProof(struct MerkleTreeBuilder.HookConfig[],address,bytes)`

```solidity
/// @notice Gets a Merkle proof for a specific hook configuration
///  @param configs All configurations in the tree
///  @param hookAddress The hook address to generate proof for
///  @param hookArgs The hook arguments to generate proof for
///  @return proof The Merkle proof (empty array for single-leaf trees)
function getProof(HookConfig[] memory configs, address hookAddress, bytes memory hookArgs) internal pure returns (bytes32[] memory proof) {
    if (configs.length == 0) return new bytes32[](0);
    bytes32 targetLeaf = _createLeaf(hookAddress, hookArgs);
    bytes32[] memory leaves = new bytes32[](configs.length);
    for (uint256 i; i < configs.length; i++) {
        leaves[i] = _createLeaf(configs[i].hookAddress, configs[i].encodedArgs);
    }
    leaves = _sortLeaves(leaves);
    if (leaves.length == 1) {
        require(leaves[0] == targetLeaf, "MerkleTreeBuilder: leaf not in tree");
        return new bytes32[](0);
    }
    return _computeProof(leaves, targetLeaf);
}
```

### _computeProof(bytes32[],bytes32)

- **Kind**: internal
- **Source**: 5656:2591:665
- **Link**: `test/utils/MerkleTreeBuilder.sol:MerkleTreeBuilder:_computeProof(bytes32[],bytes32)`

```solidity
/// @notice Computes a Merkle proof for a target leaf
///  @param leaves Array of sorted leaf hashes
///  @param targetLeaf The leaf to generate proof for
///  @return proof Array of sibling hashes forming the proof
function _computeProof(bytes32[] memory leaves, bytes32 targetLeaf) private pure returns (bytes32[] memory proof) {
    int256 targetIndex = -1;
    for (uint256 i; i < leaves.length; i++) {
        if (leaves[i] == targetLeaf) {
            targetIndex = int256(i);
            break;
        }
    }
    require(targetIndex >= 0, "MerkleTreeBuilder: leaf not in tree");
    uint256 depth = 0;
    uint256 tempSize = leaves.length;
    while (tempSize > 1) {
        depth++;
        tempSize = (tempSize + 1) / 2;
    }
    proof = new bytes32[](depth);
    uint256 proofIndex = 0;
    bytes32[] memory currentLevel = leaves;
    uint256 currentIndex = uint256(targetIndex);
    while (currentLevel.length > 1) {
        uint256 siblingIndex;
        if ((currentIndex % 2) == 0) {
            siblingIndex = currentIndex + 1;
        } else {
            siblingIndex = currentIndex - 1;
        }
        if (siblingIndex < currentLevel.length) {
            proof[proofIndex] = currentLevel[siblingIndex];
            proofIndex++;
        }
        uint256 nextLevelSize = (currentLevel.length + 1) / 2;
        bytes32[] memory nextLevel = new bytes32[](nextLevelSize);
        for (uint256 i; i < nextLevelSize; i++) {
            uint256 leftIndex = i * 2;
            uint256 rightIndex = leftIndex + 1;
            if (rightIndex < currentLevel.length) {
                nextLevel[i] = _hashPair(currentLevel[leftIndex], currentLevel[rightIndex]);
            } else {
                nextLevel[i] = currentLevel[leftIndex];
            }
        }
        currentLevel = nextLevel;
        currentIndex = currentIndex / 2;
    }
    if (proofIndex < depth) {
        bytes32[] memory resizedProof = new bytes32[](proofIndex);
        for (uint256 i; i < proofIndex; i++) {
            resizedProof[i] = proof[i];
        }
        return resizedProof;
    }
    return proof;
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **MockERC20::mint(address,uint256)**
- **Vm::mockCall(address,bytes,bytes)**
- **SuperBank::executeHooks(struct IHookExecutionData.HookExecutionData)**
- **MockERC20::balanceOf(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_MultiTargetHook_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MerkleTreeBuilder.buildTree(struct MerkleTreeBuilder.HookConfig[]) (NodeID: 1)
  │   💬 Args: [configs]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._createLeaf(address,bytes) (NodeID: 2)
  │ │   💬 Args: [configs[i].hookAddress, configs[i].encodedArgs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._sortLeaves(bytes32[]) (NodeID: 3)
  │ │   💬 Args: [leaves]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._buildTreeFromLeaves(bytes32[]) (NodeID: 4)
  │     💬 Args: [leaves]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: Helpers._hashPair(bytes32,bytes32) (NodeID: 5)
  │       💬 Args: [currentLevel[leftIndex], currentLevel[rightIndex]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MerkleTreeBuilder.getProof(struct MerkleTreeBuilder.HookConfig[],address,bytes) (NodeID: 6)
  │   💬 Args: [configs, address(multiTargetHook), hookArgs]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._createLeaf(address,bytes) (NodeID: 7)
  │ │   💬 Args: [hookAddress, hookArgs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._createLeaf(address,bytes) (NodeID: 8)
  │ │   💬 Args: [configs[i].hookAddress, configs[i].encodedArgs]
  │ │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._sortLeaves(bytes32[]) (NodeID: 9)
  │ │   💬 Args: [leaves]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: MerkleTreeBuilder._computeProof(bytes32[],bytes32) (NodeID: 10)
  │     💬 Args: [leaves, targetLeaf]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: Helpers._hashPair(bytes32,bytes32) (NodeID: 11)
  │       💬 Args: [currentLevel[leftIndex], currentLevel[rightIndex]]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [testToken.balanceOf(recipient1), transferAmount, "Recipient 1 should receive tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 13)
  │   💬 Args: [testToken.balanceOf(recipient2), transferAmount, "Recipient 2 should receive tokens"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [testToken.balanceOf(recipient3), transferAmount, "Recipient 3 should receive tokens"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 15)
      💬 Args: [testToken.balanceOf(address(superBank)), 0, "SuperBank should have transferred all tokens"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice THE CRITICAL TEST: Proves the fix for multi-target hook Merkle proof reuse issue
 @dev This test demonstrates that a single hook can now call multiple external targets
      OLD SYSTEM: Would fail with INVALID_MERKLE_PROOF because it tried to use one proof for 3 targets
      NEW SYSTEM: Validates hook configuration once, then executes all targets successfully
