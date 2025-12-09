# Function: test_VaultBankManagement_GetNonExistentVaultBank()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_GetNonExistentVaultBank()`
- **Visibility**: public
- **Source Range**: 5670:285:568

## Implementation

```solidity
/// @notice Tests getting vault bank for non-existent chain returns zero address
function test_VaultBankManagement_GetNonExistentVaultBank() public view {
    uint64 nonExistentChainId = 999;
    address result = superRegistry.getVaultBank(nonExistentChainId);
    assertEq(result, address(0), "Non-existent vault bank should return zero address");
}
```

## Related Implementations

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperRegistry::getVaultBank(uint64)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_GetNonExistentVaultBank() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [result, address(0), "Non-existent vault bank should return zero address"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests getting vault bank for non-existent chain returns zero address
