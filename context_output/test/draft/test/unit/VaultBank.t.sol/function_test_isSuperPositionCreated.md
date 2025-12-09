# Function: test_isSuperPositionCreated()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_isSuperPositionCreated()`
- **Visibility**: public
- **Source Range**: 58306:433:570

## Implementation

```solidity
function test_isSuperPositionCreated() public {
    address mockSuperPosition = address(0x1234);
    assertFalse(vaultBank.isSuperPositionCreated(mockSuperPosition), "Should return false initially");
    vaultBank.exposed_markAsSyntheticAsset(mockSuperPosition);
    assertTrue(vaultBank.isSuperPositionCreated(mockSuperPosition), "Should return true after marking as synthetic asset");
}
```

## Related Implementations

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **TestVaultBank::isSuperPositionCreated(address)**
- **TestVaultBank::exposed_markAsSyntheticAsset(address)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_isSuperPositionCreated() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [vaultBank.isSuperPositionCreated(mockSuperPosition), "Should return false initially"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
      💬 Args: [vaultBank.isSuperPositionCreated(mockSuperPosition), "Should return true after marking as synthetic asset"]
      👁️  Def: internal
```
