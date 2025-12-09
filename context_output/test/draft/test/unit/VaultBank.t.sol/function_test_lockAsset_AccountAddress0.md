# Function: test_lockAsset_AccountAddress0()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_AccountAddress0()`
- **Visibility**: public
- **Source Range**: 7178:235:570

## Implementation

```solidity
function test_lockAsset_AccountAddress0() public {
    vm.expectRevert(IVaultBankSource.INVALID_ACCOUNT.selector);
    vaultBank.lockAsset(yieldSourceOracleId, address(0), address(token), address(mockHook), 100 ether, 1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_AccountAddress0() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
