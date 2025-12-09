# Function: test_CompleteDistributionCycle()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_CompleteDistributionCycle()`
- **Visibility**: public
- **Source Range**: 5835:965:569

## Implementation

```solidity
///  Integration Tests
function test_CompleteDistributionCycle() public {
    uint256 initialDistributorBalance = UpToken.balanceOf(address(distributor));
    vm.prank(user1);
    distributor.claim(CLAIM_AMOUNT, merkleProof1);
    vm.prank(user2);
    distributor.claim(CLAIM_AMOUNT, merkleProof2);
    assertTrue(distributor.hasClaimed(user1));
    assertTrue(distributor.hasClaimed(user2));
    assertEq(UpToken.balanceOf(user1), CLAIM_AMOUNT);
    assertEq(UpToken.balanceOf(user2), CLAIM_AMOUNT);
    uint256 remainingBalance = UpToken.balanceOf(address(distributor));
    distributor.reclaimTokens(remainingBalance);
    assertEq(UpToken.balanceOf(address(distributor)), 0);
    assertEq(remainingBalance, initialDistributorBalance - (CLAIM_AMOUNT * 2));
}
```

## Related Implementations

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
    }
}
```

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
- **Vm::prank(address)**
- **UpDistributor::claim(uint256,bytes32[])**
- **UpDistributor::hasClaimed(address)**
- **UpDistributor::reclaimTokens(uint256)**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **user1** (`address`)
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)
- **user2** (`address`)
- **merkleProof2** (`bytes32[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_CompleteDistributionCycle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [distributor.hasClaimed(user1)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
  │   💬 Args: [distributor.hasClaimed(user2)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [UpToken.balanceOf(user1), CLAIM_AMOUNT]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [UpToken.balanceOf(user2), CLAIM_AMOUNT]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [UpToken.balanceOf(address(distributor)), 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [remainingBalance, initialDistributorBalance - (CLAIM_AMOUNT * 2)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Integration Tests
