# Function: test_unlockAsset_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_unlockAsset_Success()`
- **Visibility**: public
- **Source Range**: 18563:1768:570

## Implementation

```solidity
function test_unlockAsset_Success() public {
    uint256 lockAmount = 100 ether;
    token.mint(user, lockAmount);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, DST_CHAIN_ID);
    assertEq(token.balanceOf(user), 0, "Initial user balance incorrect");
    assertEq(token.balanceOf(address(vaultBank)), lockAmount, "Initial vault balance incorrect");
    uint256 unlockAmount = lockAmount / 2;
    mockProver.setEmittingContract(address(vaultBank));
    mockProver.mockSuperpositionsBurnedEvent(user, address(token), unlockAmount, CURRENT_CHAIN_ID, 0, uint32(DST_CHAIN_ID), yieldSourceOracleId);
    bytes memory mockProof = new bytes(0);
    uint256 expectedNonce = vaultBank.nonces(CURRENT_CHAIN_ID);
    vm.expectEmit(true, true, false, true);
    emit IVaultBankSource.SharesUnlocked(yieldSourceOracleId, user, address(token), unlockAmount, CURRENT_CHAIN_ID, DST_CHAIN_ID, expectedNonce);
    vaultBank.unlockAsset(user, address(token), unlockAmount, DST_CHAIN_ID, yieldSourceOracleId, mockProof);
    assertEq(vaultBank.nonces(CURRENT_CHAIN_ID), expectedNonce + 1, "Nonce not incremented");
    assertEq(token.balanceOf(user), unlockAmount, "User balance after unlock incorrect");
    assertEq(token.balanceOf(address(vaultBank)), lockAmount - unlockAmount, "Vault balance after unlock incorrect");
    assertEq(vaultBank.viewTotalLockedAsset(address(token)), lockAmount - unlockAmount, "Total locked amount after unlock incorrect");
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

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**
- **MockERC20::balanceOf(address)**
- **MockCrossL2ProverV2::setEmittingContract(address)**
- **MockCrossL2ProverV2::mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)**
- **TestVaultBank::nonces(uint64)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **TestVaultBank::unlockAsset(address,address,uint256,uint64,bytes32,bytes)**
- **TestVaultBank::viewTotalLockedAsset(address)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]
- **DST_CHAIN_ID** (`uint64`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]
- **CURRENT_CHAIN_ID** (`uint64`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_unlockAsset_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [token.balanceOf(user), 0, "Initial user balance incorrect"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [token.balanceOf(address(vaultBank)), lockAmount, "Initial vault balance incorrect"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [vaultBank.nonces(CURRENT_CHAIN_ID), expectedNonce + 1, "Nonce not incremented"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [token.balanceOf(user), unlockAmount, "User balance after unlock incorrect"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [token.balanceOf(address(vaultBank)), lockAmount - unlockAmount, "Vault balance after unlock incorrect"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [vaultBank.viewTotalLockedAsset(address(token)), lockAmount - unlockAmount, "Total locked amount after unlock incorrect"]
      👁️  Def: internal
```
