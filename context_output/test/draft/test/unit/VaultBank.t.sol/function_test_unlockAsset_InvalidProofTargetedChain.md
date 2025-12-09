# Function: test_unlockAsset_InvalidProofTargetedChain()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_unlockAsset_InvalidProofTargetedChain()`
- **Visibility**: public
- **Source Range**: 13711:1016:570

## Implementation

```solidity
function test_unlockAsset_InvalidProofTargetedChain() public {
    uint256 lockAmount = 100 ether;
    token.mint(user, lockAmount);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, DST_CHAIN_ID);
    mockProver.setValidateEventReturn(uint32(DST_CHAIN_ID), address(vaultBank), new bytes(128), abi.encode(lockAmount, CURRENT_CHAIN_ID + 1, 0));
    mockProver.setEmittingContract(address(vaultBank));
    mockProver.mockSuperpositionsBurnedEvent(user, address(token), lockAmount, CURRENT_CHAIN_ID + 1, 0, uint32(DST_CHAIN_ID), yieldSourceOracleId);
    bytes memory mockProof = new bytes(0);
    vm.expectRevert(IVaultBank.INVALID_PROOF_TARGETED_CHAIN.selector);
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
- **MockCrossL2ProverV2::setEmittingContract(address)**
- **MockCrossL2ProverV2::mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)**
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
- **CURRENT_CHAIN_ID** (`uint64`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_unlockAsset_InvalidProofTargetedChain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
