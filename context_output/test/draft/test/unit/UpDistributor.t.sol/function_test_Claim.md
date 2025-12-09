# Function: test_Claim()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_Claim()`
- **Visibility**: public
- **Source Range**: 2672:303:569

## Implementation

```solidity
///  Claim Tests
function test_Claim() public {
    uint256 initialBalance = UpToken.balanceOf(user1);
    vm.prank(user1);
    distributor.claim(CLAIM_AMOUNT, merkleProof1);
    assertEq(UpToken.balanceOf(user1), initialBalance + CLAIM_AMOUNT);
    assertTrue(distributor.hasClaimed(user1));
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

## External Calls

- **Up::balanceOf(address)**
- **Vm::prank(address)**
- **UpDistributor::claim(uint256,bytes32[])**
- **UpDistributor::hasClaimed(address)**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_Claim() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UpToken.balanceOf(user1), initialBalance + CLAIM_AMOUNT]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
      💬 Args: [distributor.hasClaimed(user1)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Claim Tests
