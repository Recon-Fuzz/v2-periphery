# Function: test_RevertWhen_ReclaimingTokensByNonOwner()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_ReclaimingTokensByNonOwner()`
- **Visibility**: public
- **Source Range**: 5274:232:569

## Implementation

```solidity
function test_RevertWhen_ReclaimingTokensByNonOwner() public {
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
    distributor.reclaimTokens(1);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **UpDistributor::reclaimTokens(uint256)**

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_ReclaimingTokensByNonOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
