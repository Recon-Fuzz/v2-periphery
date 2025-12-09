# Function: test_RevertWhen_MintingTooEarly()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_RevertWhen_MintingTooEarly()`
- **Visibility**: public
- **Source Range**: 3639:483:663

## Implementation

```solidity
function test_RevertWhen_MintingTooEarly() public {
    vm.warp((block.timestamp + INITIAL_MINT_LOCK) + DAYS_PER_YEAR);
    uint256 maxMintAmount = (UpToken.totalSupply() * MINT_CAP_BPS) / 10_000;
    UpToken.mint(user1, maxMintAmount);
    vm.expectRevert(abi.encodeWithSignature("MintingTooEarly()"));
    UpToken.mint(user2, 1000);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Up::totalSupply()**
- **Up::mint(address,uint256)**
- **Vm::expectRevert(bytes)**

## State Variable Reads

- **INITIAL_MINT_LOCK** (`uint256`)
- **DAYS_PER_YEAR** (`uint256`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **MINT_CAP_BPS** (`uint256`)
- **user1** (`address`)
- **user2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_RevertWhen_MintingTooEarly() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
