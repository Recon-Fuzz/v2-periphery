# Function: test_NewDistributionCycle()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_NewDistributionCycle()`
- **Visibility**: public
- **Source Range**: 6806:778:569

## Implementation

```solidity
function test_NewDistributionCycle() public {
    vm.prank(user1);
    distributor.claim(CLAIM_AMOUNT, merkleProof1);
    bytes32 newRoot = keccak256("new root");
    distributor.setMerkleRoot(newRoot);
    assertTrue(distributor.hasClaimed(user1));
    UpToken.transfer(address(distributor), CLAIM_AMOUNT * 2);
    uint256 remainingBalance = UpToken.balanceOf(address(distributor));
    distributor.reclaimTokens(remainingBalance);
    assertEq(UpToken.balanceOf(address(distributor)), 0);
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

- **Vm::prank(address)**
- **UpDistributor::claim(uint256,bytes32[])**
- **UpDistributor::setMerkleRoot(bytes32)**
- **UpDistributor::hasClaimed(address)**
- **Up::transfer(address,uint256)**
- **Up::balanceOf(address)**
- **UpDistributor::reclaimTokens(uint256)**

## Native Transfers

- **UpToken** (state variable) [src/UP/Up.sol/contract_Up.md]

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_NewDistributionCycle() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
  │   💬 Args: [distributor.hasClaimed(user1)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [UpToken.balanceOf(address(distributor)), 0]
      👁️  Def: internal
```
