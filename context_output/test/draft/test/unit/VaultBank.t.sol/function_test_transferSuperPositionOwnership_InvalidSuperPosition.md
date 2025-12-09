# Function: test_transferSuperPositionOwnership_InvalidSuperPosition()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_transferSuperPositionOwnership_InvalidSuperPosition()`
- **Visibility**: public
- **Source Range**: 66402:408:570

## Implementation

```solidity
function test_transferSuperPositionOwnership_InvalidSuperPosition() public {
    address invalidSP = address(0x1111);
    address newOwner = address(0x9999);
    vm.expectRevert();
    vaultBank.transferSuperPositionOwnership(invalidSP, newOwner);
}
```

## External Calls

- **Vm::expectRevert()**
- **TestVaultBank::transferSuperPositionOwnership(address,address)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_transferSuperPositionOwnership_InvalidSuperPosition() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
