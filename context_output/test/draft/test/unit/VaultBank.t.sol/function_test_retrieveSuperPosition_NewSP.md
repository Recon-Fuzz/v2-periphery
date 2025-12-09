# Function: test_retrieveSuperPosition_NewSP()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_retrieveSuperPosition_NewSP()`
- **Visibility**: public
- **Source Range**: 61117:975:570

## Implementation

```solidity
function test_retrieveSuperPosition_NewSP() public {
    address mockToken = address(0x9ABC);
    uint64 mockChainId = 6;
    string memory name = "New Token";
    string memory symbol = "NTKN";
    uint8 decimals = 18;
    address retrievedSP = vaultBank.exposed_retrieveSuperPosition(yieldSourceOracleId, mockChainId, mockToken, name, symbol, decimals);
    assertFalse(retrievedSP == address(0), "Should not return zero address");
    assertTrue(vaultBank.isSuperPositionCreated(retrievedSP), "Should mark new SP as created");
    assertEq(vaultBank.getSuperPositionForAsset(mockChainId, mockToken, yieldSourceOracleId), retrievedSP, "Should set token to SP mapping");
    assertEq(vaultBank.getAssetForSuperPosition(mockChainId, retrievedSP, yieldSourceOracleId), mockToken, "Should set SP to token mapping");
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

- **TestVaultBank::exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)**
- **TestVaultBank::isSuperPositionCreated(address)**
- **TestVaultBank::getSuperPositionForAsset(uint64,address,bytes32)**
- **TestVaultBank::getAssetForSuperPosition(uint64,address,bytes32)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_retrieveSuperPosition_NewSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [retrievedSP == address(0), "Should not return zero address"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [vaultBank.isSuperPositionCreated(retrievedSP), "Should mark new SP as created"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [vaultBank.getSuperPositionForAsset(mockChainId, mockToken, yieldSourceOracleId), retrievedSP, "Should set token to SP mapping"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [vaultBank.getAssetForSuperPosition(mockChainId, retrievedSP, yieldSourceOracleId), mockToken, "Should set SP to token mapping"]
      👁️  Def: internal
```
