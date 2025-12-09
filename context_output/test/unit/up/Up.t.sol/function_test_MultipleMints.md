# Function: test_MultipleMints()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_MultipleMints()`
- **Visibility**: public
- **Source Range**: 2606:731:663

## Implementation

```solidity
function test_MultipleMints() public {
    vm.warp((block.timestamp + INITIAL_MINT_LOCK) + DAYS_PER_YEAR);
    uint256 maxMintAmount = (UpToken.totalSupply() * MINT_CAP_BPS) / 10_000;
    UpToken.mint(user1, maxMintAmount / 2);
    vm.warp(block.timestamp + DAYS_PER_YEAR);
    uint256 newMaxMintAmount = (UpToken.totalSupply() * MINT_CAP_BPS) / 10_000;
    UpToken.mint(user2, newMaxMintAmount / 2);
    assertEq(UpToken.balanceOf(user1), maxMintAmount / 2);
    assertEq(UpToken.balanceOf(user2), newMaxMintAmount / 2);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::warp(uint256)**
- **Up::totalSupply()**
- **Up::mint(address,uint256)**
- **Up::balanceOf(address)**

## State Variable Reads

- **INITIAL_MINT_LOCK** (`uint256`)
- **DAYS_PER_YEAR** (`uint256`)
- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **MINT_CAP_BPS** (`uint256`)
- **user1** (`address`)
- **user2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_MultipleMints() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UpToken.balanceOf(user1), maxMintAmount / 2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [UpToken.balanceOf(user2), newMaxMintAmount / 2]
      👁️  Def: internal
```
