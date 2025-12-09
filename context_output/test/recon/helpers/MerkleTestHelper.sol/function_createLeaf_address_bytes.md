# Function: createLeaf(address,bytes)

**Contract**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

## Metadata

- **Contract**: MerkleTestHelper
- **Signature**: `createLeaf(address,bytes)`
- **Visibility**: public
- **Source Range**: 5598:192:633

## Implementation

```solidity
/// @notice Create a leaf hash for a specific hook and arguments
///  @param hookAddress Address of the hook contract
///  @param hookArgs Encoded hook arguments
///  @return leaf The leaf hash
function createLeaf(address hookAddress, bytes memory hookArgs) public pure returns (bytes32 leaf) {
    return keccak256(bytes.concat(keccak256(abi.encode(hookAddress, hookArgs))));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerkleTestHelper.createLeaf(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Create a leaf hash for a specific hook and arguments
 @param hookAddress Address of the hook contract
 @param hookArgs Encoded hook arguments
 @return leaf The leaf hash
