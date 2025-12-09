# Function: test_transferSuperPositionOwnership_ZeroAddress()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_transferSuperPositionOwnership_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 65987:409:570

## Implementation

```solidity
function test_transferSuperPositionOwnership_ZeroAddress() public {
    VaultBankSuperPosition testSP = new VaultBankSuperPosition("TestSP", "TSP", 18, yieldSourceOracleId);
    vm.expectRevert();
    vaultBank.transferSuperPositionOwnership(address(testSP), address(0));
}
```

## External Calls

- **Vm::expectRevert()**
- **TestVaultBank::transferSuperPositionOwnership(address,address)**

## State Variable Reads

- **yieldSourceOracleId** (`bytes32`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_transferSuperPositionOwnership_ZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
