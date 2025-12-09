# Function: test_RevertWhen_MintExceedsMaxAmount()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_MintExceedsMaxAmount()`
- **Visibility**: public
- **Source Range**: 4128:334:663

## Implementation

```solidity
function test_RevertWhen_MintExceedsMaxAmount() public {
    vm.warp((block.timestamp + INITIAL_MINT_LOCK) + DAYS_PER_YEAR);
    uint256 maxMintAmount = (UpToken.totalSupply() * MINT_CAP_BPS) / 10_000;
    vm.expectRevert(abi.encodeWithSignature("MintAmountTooHigh()"));
    UpToken.mint(user1, maxMintAmount + 1);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Up::totalSupply()**
- **Vm::expectRevert(bytes)**
- **Up::mint(address,uint256)**

## State Variable Reads

- **INITIAL_MINT_LOCK** (`uint256`)
- **DAYS_PER_YEAR** (`uint256`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **MINT_CAP_BPS** (`uint256`)
- **user1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_MintExceedsMaxAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
