# Function: test_lockAsset_InvalidHook()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_InvalidHook()`
- **Visibility**: public
- **Source Range**: 7419:177:570

## Implementation

```solidity
function test_lockAsset_InvalidHook() public {
    vm.expectRevert();
    vaultBank.lockAsset(yieldSourceOracleId, user, address(token), address(0), 100 ether, 1);
}
```

## External Calls

- **Vm::expectRevert()**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **user** (`address`)
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_InvalidHook() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
