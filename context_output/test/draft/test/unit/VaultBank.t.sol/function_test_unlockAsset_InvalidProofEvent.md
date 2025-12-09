# Function: test_unlockAsset_InvalidProofEvent()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_unlockAsset_InvalidProofEvent()`
- **Visibility**: public
- **Source Range**: 10790:923:570

## Implementation

```solidity
function test_unlockAsset_InvalidProofEvent() public {
    uint256 lockAmount = 100 ether;
    token.mint(user, lockAmount);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, DST_CHAIN_ID);
    bytes memory invalidTopics = new bytes(128);
    bytes32 invalidEventSelector = bytes32(uint256(0x12345678));
    assembly {
        mstore(add(invalidTopics, 32), invalidEventSelector)
    }
    mockProver.setValidateEventReturn(uint32(DST_CHAIN_ID), address(vaultBank), invalidTopics, new bytes(0));
    bytes memory mockProof = new bytes(0);
    vm.expectRevert(IVaultBank.INVALID_PROOF_EVENT.selector);
    vaultBank.unlockAsset(user, address(token), lockAmount, DST_CHAIN_ID, yieldSourceOracleId, mockProof);
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**
- **MockCrossL2ProverV2::setValidateEventReturn(uint32,address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::unlockAsset(address,address,uint256,uint64,bytes32,bytes)**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]
- **DST_CHAIN_ID** (`uint64`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_unlockAsset_InvalidProofEvent() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
