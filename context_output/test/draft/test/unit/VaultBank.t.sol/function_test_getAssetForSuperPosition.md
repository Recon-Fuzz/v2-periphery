# Function: test_getAssetForSuperPosition()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_getAssetForSuperPosition()`
- **Visibility**: public
- **Source Range**: 57589:711:570

## Implementation

```solidity
function test_getAssetForSuperPosition() public {
    address mockSuperPosition = address(0x1234);
    address mockToken = address(0x5678);
    uint64 mockChainId = 5;
    assertEq(vaultBank.getAssetForSuperPosition(mockChainId, mockSuperPosition, yieldSourceOracleId), address(0), "Should return zero address initially");
    vaultBank.exposed_setSuperPositionToToken(mockSuperPosition, mockChainId, mockToken, yieldSourceOracleId);
    assertEq(vaultBank.getAssetForSuperPosition(mockChainId, mockSuperPosition, yieldSourceOracleId), mockToken, "Should return correct token address");
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

- **TestVaultBank::getAssetForSuperPosition(uint64,address,bytes32)**
- **TestVaultBank::exposed_setSuperPositionToToken(address,uint64,address,bytes32)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_getAssetForSuperPosition() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [vaultBank.getAssetForSuperPosition(mockChainId, mockSuperPosition, yieldSourceOracleId), address(0), "Should return zero address initially"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [vaultBank.getAssetForSuperPosition(mockChainId, mockSuperPosition, yieldSourceOracleId), mockToken, "Should return correct token address"]
      👁️  Def: internal
```
