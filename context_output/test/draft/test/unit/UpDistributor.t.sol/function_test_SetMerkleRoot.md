# Function: test_SetMerkleRoot()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_SetMerkleRoot()`
- **Visibility**: public
- **Source Range**: 2179:190:569

## Implementation

```solidity
///  Merkle Root Tests
function test_SetMerkleRoot() public {
    bytes32 newRoot = keccak256("new root");
    distributor.setMerkleRoot(newRoot);
    assertEq(distributor.merkleRoot(), newRoot);
}
```

## Related Implementations

### assertEq(bytes32,bytes32)

- **Kind**: internal
- **Source**: 4362:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32)`

```solidity
function assertEq(bytes32 left, bytes32 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **UpDistributor::setMerkleRoot(bytes32)**
- **UpDistributor::merkleRoot()**

## State Variable Reads

- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_SetMerkleRoot() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 1)
      💬 Args: [distributor.merkleRoot(), newRoot]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Merkle Root Tests
