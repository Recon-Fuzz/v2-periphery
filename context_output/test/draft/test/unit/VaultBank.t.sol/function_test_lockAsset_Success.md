# Function: test_lockAsset_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_Success()`
- **Visibility**: public
- **Source Range**: 7907:1372:570

## Implementation

```solidity
function test_lockAsset_Success() public {
    token.mint(user, 100 ether);
    vm.startPrank(user);
    token.approve(address(vaultBank), 100 ether);
    vm.stopPrank();
    uint64 destinationChainId = 10;
    uint256 lockAmount = 50 ether;
    uint256 expectedNonce = vaultBank.nonces(destinationChainId);
    vm.expectEmit(true, true, false, true);
    emit IVaultBankSource.SharesLocked(yieldSourceOracleId, user, address(token), lockAmount, uint64(block.chainid), destinationChainId, expectedNonce);
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, destinationChainId);
    assertEq(vaultBank.nonces(destinationChainId), expectedNonce + 1, "Nonce not incremented");
    assertEq(vaultBank.viewTotalLockedAsset(address(token)), lockAmount, "Total locked amount incorrect");
    assertEq(vaultBank.viewAllLockedAssets().length, 1, "Locked assets length incorrect");
    assertEq(vaultBank.viewAllLockedAssets()[0], address(token), "Token not in locked assets");
    assertEq(token.balanceOf(address(vaultBank)), lockAmount, "VaultBank balance incorrect");
    assertEq(token.balanceOf(user), 50 ether, "User balance incorrect");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::nonces(uint64)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**
- **TestVaultBank::viewTotalLockedAsset(address)**
- **TestVaultBank::viewAllLockedAssets()**
- **MockERC20::balanceOf(address)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [vaultBank.nonces(destinationChainId), expectedNonce + 1, "Nonce not incremented"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [vaultBank.viewTotalLockedAsset(address(token)), lockAmount, "Total locked amount incorrect"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [vaultBank.viewAllLockedAssets().length, 1, "Locked assets length incorrect"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [vaultBank.viewAllLockedAssets()[0], address(token), "Token not in locked assets"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [token.balanceOf(address(vaultBank)), lockAmount, "VaultBank balance incorrect"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [token.balanceOf(user), 50 ether, "User balance incorrect"]
      👁️  Def: internal
```
