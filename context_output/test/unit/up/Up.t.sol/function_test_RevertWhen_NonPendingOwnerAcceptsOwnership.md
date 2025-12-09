# Function: test_RevertWhen_NonPendingOwnerAcceptsOwnership()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_NonPendingOwnerAcceptsOwnership()`
- **Visibility**: public
- **Source Range**: 5283:276:663

## Implementation

```solidity
function test_RevertWhen_NonPendingOwnerAcceptsOwnership() public {
    UpToken.transferOwnership(user1);
    vm.prank(user2);
    vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user2));
    UpToken.acceptOwnership();
}
```

## External Calls

- **Up::transferOwnership(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **Up::acceptOwnership()**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)
- **user2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_NonPendingOwnerAcceptsOwnership() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
