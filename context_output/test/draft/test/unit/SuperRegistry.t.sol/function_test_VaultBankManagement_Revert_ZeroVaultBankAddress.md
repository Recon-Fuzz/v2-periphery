# Function: test_VaultBankManagement_Revert_ZeroVaultBankAddress()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_Revert_ZeroVaultBankAddress()`
- **Visibility**: public
- **Source Range**: 5316:263:568

## Implementation

```solidity
/// @notice Tests reverting when adding vault bank with zero address
function test_VaultBankManagement_Revert_ZeroVaultBankAddress() public {
    uint64 chainId = 1;
    vm.prank(registryAdmin);
    vm.expectRevert(ISuperRegistry.INVALID_ADDRESS.selector);
    superRegistry.addVaultBank(chainId, address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::addVaultBank(uint64,address)**

## State Variable Reads

- **registryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_Revert_ZeroVaultBankAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when adding vault bank with zero address
