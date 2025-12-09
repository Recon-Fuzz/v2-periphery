# Function: test_ClaimOnBehalf()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_ClaimOnBehalf()`
- **Visibility**: public
- **Source Range**: 3747:223:569

## Implementation

```solidity
function test_ClaimOnBehalf() public {
    distributor.claimOnBehalf(user1, CLAIM_AMOUNT, merkleProof1);
    assertEq(UpToken.balanceOf(user1), CLAIM_AMOUNT);
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

- **UpDistributor::claimOnBehalf(address,uint256,bytes32[])**
- **Up::balanceOf(address)**
- **UpDistributor::hasClaimed(address)**

## State Variable Reads

- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **user1** (`address`)
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_ClaimOnBehalf() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UpToken.balanceOf(user1), CLAIM_AMOUNT]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
      💬 Args: [distributor.hasClaimed(user1)]
      👁️  Def: internal
```
