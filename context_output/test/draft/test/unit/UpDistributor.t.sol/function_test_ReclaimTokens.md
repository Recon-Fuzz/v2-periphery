# Function: test_ReclaimTokens()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_ReclaimTokens()`
- **Visibility**: public
- **Source Range**: 4887:381:569

## Implementation

```solidity
///  Token Reclamation Tests
function test_ReclaimTokens() public {
    uint256 initialBalance = UpToken.balanceOf(owner);
    uint256 distributorBalance = UpToken.balanceOf(address(distributor));
    distributor.reclaimTokens(distributorBalance);
    assertEq(UpToken.balanceOf(owner), initialBalance + distributorBalance);
    assertEq(UpToken.balanceOf(address(distributor)), 0);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Up::balanceOf(address)**
- **UpDistributor::reclaimTokens(uint256)**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **owner** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_ReclaimTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UpToken.balanceOf(owner), initialBalance + distributorBalance]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [UpToken.balanceOf(address(distributor)), 0]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Token Reclamation Tests
