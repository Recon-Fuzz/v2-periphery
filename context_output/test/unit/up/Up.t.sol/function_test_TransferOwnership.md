# Function: test_TransferOwnership()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_TransferOwnership()`
- **Visibility**: public
- **Source Range**: 4793:242:663

## Implementation

```solidity
///  Ownership Tests
function test_TransferOwnership() public {
    UpToken.transferOwnership(user1);
    assertEq(UpToken.pendingOwner(), user1);
    vm.prank(user1);
    UpToken.acceptOwnership();
    assertEq(UpToken.owner(), user1);
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

## External Calls

- **Up::transferOwnership(address)**
- **Up::pendingOwner()**
- **Vm::prank(address)**
- **Up::acceptOwnership()**
- **Up::owner()**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_TransferOwnership() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
  │   💬 Args: [UpToken.pendingOwner(), user1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [UpToken.owner(), user1]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Ownership Tests
