# Function: test_RevertWhen_ClaimingOnBehalfAlreadyClaimed()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_ClaimingOnBehalfAlreadyClaimed()`
- **Visibility**: public
- **Source Range**: 4483:337:569

## Implementation

```solidity
function test_RevertWhen_ClaimingOnBehalfAlreadyClaimed() public {
    vm.startPrank(user1);
    distributor.claimOnBehalf(user1, CLAIM_AMOUNT, merkleProof1);
    vm.expectRevert(abi.encodeWithSignature("ALREADY_CLAIMED()"));
    distributor.claimOnBehalf(user1, CLAIM_AMOUNT, merkleProof1);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **UpDistributor::claimOnBehalf(address,uint256,bytes32[])**
- **Vm::expectRevert(bytes)**
- **Vm::stopPrank()**

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_ClaimingOnBehalfAlreadyClaimed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
