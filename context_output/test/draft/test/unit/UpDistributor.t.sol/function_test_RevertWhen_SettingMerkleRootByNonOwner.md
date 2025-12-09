# Function: test_RevertWhen_SettingMerkleRootByNonOwner()

**Contract**: [test/draft/test/unit/UpDistributor.t.sol/contract_UpDistributorTest.md]

## Metadata

- **Contract**: UpDistributorTest
- **Signature**: `test_RevertWhen_SettingMerkleRootByNonOwner()`
- **Visibility**: public
- **Source Range**: 2375:242:569

## Implementation

```solidity
function test_RevertWhen_SettingMerkleRootByNonOwner() public {
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
    distributor.setMerkleRoot(bytes32(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **UpDistributor::setMerkleRoot(bytes32)**

## State Variable Reads

- **user1** (`address`)
- **distributor** (`contract UpDistributor`) [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributorTest.test_RevertWhen_SettingMerkleRootByNonOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
