# Function: test_lockAsset_TokenAddress0()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_lockAsset_TokenAddress0()`
- **Visibility**: public
- **Source Range**: 6951:221:570

## Implementation

```solidity
function test_lockAsset_TokenAddress0() public {
    vm.expectRevert(IVaultBankSource.INVALID_TOKEN.selector);
    vaultBank.lockAsset(yieldSourceOracleId, user, address(0), address(mockHook), 100 ether, 1);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **TestVaultBank::lockAsset(bytes32,address,address,address,uint256,uint64)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **user** (`address`)
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_lockAsset_TokenAddress0() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
