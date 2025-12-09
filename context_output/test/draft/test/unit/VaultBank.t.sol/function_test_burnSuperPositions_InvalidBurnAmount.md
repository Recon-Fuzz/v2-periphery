# Function: test_burnSuperPositions_InvalidBurnAmount()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_burnSuperPositions_InvalidBurnAmount()`
- **Visibility**: public
- **Source Range**: 41650:876:570

## Implementation

```solidity
function test_burnSuperPositions_InvalidBurnAmount() public {
    address validSP = address(0x1234);
    address underlyingToken = address(0x5678);
    uint256 userBalance = 5e18;
    uint256 burnAmount = 10e18;
    uint64 forChainId = 1;
    vm.etch(validSP, new bytes(0x1000));
    vaultBank.exposed_markAsSyntheticAsset(validSP);
    vaultBank.exposed_setSuperPositionToToken(validSP, forChainId, underlyingToken, yieldSourceOracleId);
    vaultBank.exposed_setTokenToSuperPosition(forChainId, underlyingToken, validSP, yieldSourceOracleId);
    vm.mockCall(validSP, abi.encodeWithSignature("balanceOf(address)", address(this)), abi.encode(userBalance));
    vm.expectRevert(IVaultBankDestination.INVALID_BURN_AMOUNT.selector);
    vaultBank.burnSuperPosition(burnAmount, validSP, forChainId, yieldSourceOracleId);
}
```

## External Calls

- **Vm::etch(address,bytes)**
- **TestVaultBank::exposed_markAsSyntheticAsset(address)**
- **TestVaultBank::exposed_setSuperPositionToToken(address,uint64,address,bytes32)**
- **TestVaultBank::exposed_setTokenToSuperPosition(uint64,address,address,bytes32)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::burnSuperPosition(uint256,address,uint64,bytes32)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_burnSuperPositions_InvalidBurnAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
