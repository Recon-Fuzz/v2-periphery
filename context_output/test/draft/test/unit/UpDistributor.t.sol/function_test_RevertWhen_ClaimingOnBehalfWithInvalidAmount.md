# Function: test_RevertWhen_ClaimingOnBehalfWithInvalidAmount()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_ClaimingOnBehalfWithInvalidAmount()`
- **Visibility**: public
- **Source Range**: 4227:250:569

## Implementation

```solidity
function test_RevertWhen_ClaimingOnBehalfWithInvalidAmount() public {
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSignature("INVALID_MERKLE_PROOF()"));
    distributor.claimOnBehalf(user1, CLAIM_AMOUNT + 1, merkleProof1);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **UpDistributor::claimOnBehalf(address,uint256,bytes32[])**

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_ClaimingOnBehalfWithInvalidAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
