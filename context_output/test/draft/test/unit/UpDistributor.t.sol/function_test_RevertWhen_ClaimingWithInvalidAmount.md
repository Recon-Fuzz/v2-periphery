# Function: test_RevertWhen_ClaimingWithInvalidAmount()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_ClaimingWithInvalidAmount()`
- **Visibility**: public
- **Source Range**: 3209:227:569

## Implementation

```solidity
function test_RevertWhen_ClaimingWithInvalidAmount() public {
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSignature("INVALID_MERKLE_PROOF()"));
    distributor.claim(CLAIM_AMOUNT + 1, merkleProof1);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **UpDistributor::claim(uint256,bytes32[])**

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]
- **CLAIM_AMOUNT** (`uint256`)
- **merkleProof1** (`bytes32[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_ClaimingWithInvalidAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
