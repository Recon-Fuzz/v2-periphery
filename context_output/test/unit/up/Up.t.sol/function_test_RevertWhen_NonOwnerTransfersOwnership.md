# Function: test_RevertWhen_NonOwnerTransfersOwnership()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_NonOwnerTransfersOwnership()`
- **Visibility**: public
- **Source Range**: 5041:236:663

## Implementation

```solidity
function test_RevertWhen_NonOwnerTransfersOwnership() public {
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
    UpToken.transferOwnership(user2);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **Up::transferOwnership(address)**

## State Variable Reads

- **user1** (`address`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_NonOwnerTransfersOwnership() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
