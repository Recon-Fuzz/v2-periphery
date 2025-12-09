# Function: test_RevertWhen_MintingBeforeLockPeriod()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_MintingBeforeLockPeriod()`
- **Visibility**: public
- **Source Range**: 3343:290:663

## Implementation

```solidity
function test_RevertWhen_MintingBeforeLockPeriod() public {
    vm.warp((block.timestamp + INITIAL_MINT_LOCK) - 1);
    vm.expectRevert(abi.encodeWithSignature("InitialLockPeriodNotOver()"));
    UpToken.mint(user1, 1000);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes)**
- **Up::mint(address,uint256)**

## State Variable Reads

- **INITIAL_MINT_LOCK** (`uint256`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **user1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_MintingBeforeLockPeriod() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
