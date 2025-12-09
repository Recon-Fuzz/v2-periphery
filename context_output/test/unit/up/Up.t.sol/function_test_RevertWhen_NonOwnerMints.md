# Function: test_RevertWhen_NonOwnerMints()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_NonOwnerMints()`
- **Visibility**: public
- **Source Range**: 4468:266:663

## Implementation

```solidity
function test_RevertWhen_NonOwnerMints() public {
    vm.warp(block.timestamp + DAYS_PER_YEAR);
    vm.prank(user1);
    vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user1));
    UpToken.mint(user1, 1000);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes)**
- **Up::mint(address,uint256)**

## State Variable Reads

- **DAYS_PER_YEAR** (`uint256`)
- **user1** (`address`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_NonOwnerMints() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
