# Function: test_burnSuperPositions_SuperPositionNotFound()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_burnSuperPositions_SuperPositionNotFound()`
- **Visibility**: public
- **Source Range**: 41154:490:570

## Implementation

```solidity
function test_burnSuperPositions_SuperPositionNotFound() public {
    address nonExistentSP = address(0xdeadbeef);
    uint256 amount = 1e18;
    uint64 forChainId = 1;
    vm.mockCall(address(vaultBank), abi.encodeWithSignature("_spAssets(address)", nonExistentSP), abi.encode(false));
    vm.expectRevert(IVaultBankDestination.SUPERPOSITION_ASSET_NOT_FOUND.selector);
    vaultBank.burnSuperPosition(amount, nonExistentSP, forChainId, yieldSourceOracleId);
}
```

## External Calls

- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::burnSuperPosition(uint256,address,uint64,bytes32)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_burnSuperPositions_SuperPositionNotFound() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
