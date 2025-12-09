# Function: test_Constructor()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_Constructor()`
- **Visibility**: public
- **Source Range**: 1903:215:569

## Implementation

```solidity
///  Constructor Tests
function test_Constructor() public view {
    assertEq(address(distributor.token()), address(UpToken));
    assertEq(distributor.owner(), owner);
    assertEq(distributor.merkleRoot(), merkleRoot);
}
```

## Related Implementations

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

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

- **UpDistributor::token()**
- **UpDistributor::owner()**
- **UpDistributor::merkleRoot()**

## State Variable Reads

- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **owner** (`address`)
- **merkleRoot** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_Constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
  │   💬 Args: [address(distributor.token()), address(UpToken)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
  │   💬 Args: [distributor.owner(), owner]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32) (NodeID: 3)
      💬 Args: [distributor.merkleRoot(), merkleRoot]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Constructor Tests
