# Function: test_unlockAsset_InvalidAmount()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_unlockAsset_InvalidAmount()`
- **Visibility**: public
- **Source Range**: 17338:1219:570

## Implementation

```solidity
function test_unlockAsset_InvalidAmount() public {
    uint256 lockAmount = 100 ether;
    token.mint(user, lockAmount);
    vm.startPrank(user);
    token.approve(address(vaultBank), lockAmount);
    vm.stopPrank();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(mockHook), lockAmount, DST_CHAIN_ID);
    mockProver.setEmittingContract(address(vaultBank));
    mockProver.mockSuperpositionsBurnedEvent(user, address(token), 0, CURRENT_CHAIN_ID, 0, uint32(DST_CHAIN_ID), yieldSourceOracleId);
    bytes memory mockProof = new bytes(0);
    vm.expectRevert(IVaultBankSource.INVALID_AMOUNT.selector);
    vaultBank.unlockAsset(user, address(token), 0, DST_CHAIN_ID, yieldSourceOracleId, mockProof);
    mockProver.setEmittingContract(address(vaultBank));
    mockProver.mockSuperpositionsBurnedEvent(user, address(token), lockAmount * 2, CURRENT_CHAIN_ID, 1, uint32(DST_CHAIN_ID), yieldSourceOracleId);
    vm.expectRevert(IVaultBankSource.INVALID_AMOUNT.selector);
    vaultBank.unlockAsset(user, address(token), lockAmount * 2, DST_CHAIN_ID, yieldSourceOracleId, mockProof);
}
```

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20::approve(address,uint256)**
- **Vm::stopPrank()**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**
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
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_unlockAsset_InvalidAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
