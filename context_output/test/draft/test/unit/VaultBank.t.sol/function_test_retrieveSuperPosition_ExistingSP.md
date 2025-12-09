# Function: test_retrieveSuperPosition_ExistingSP()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_retrieveSuperPosition_ExistingSP()`
- **Visibility**: public
- **Source Range**: 60553:558:570

## Implementation

```solidity
function test_retrieveSuperPosition_ExistingSP() public {
    address existingSPAddress = address(0x1234);
    address mockToken = address(0x5678);
    uint64 mockChainId = 5;
    vaultBank.exposed_setTokenToSuperPosition(mockChainId, mockToken, existingSPAddress, yieldSourceOracleId);
    address retrievedSP = vaultBank.exposed_retrieveSuperPosition(yieldSourceOracleId, mockChainId, mockToken, "Token", "TKN", 18);
    assertEq(retrievedSP, existingSPAddress, "Should return existing super position address");
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

- **TestVaultBank::exposed_setTokenToSuperPosition(uint64,address,address,bytes32)**
- **TestVaultBank::exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_retrieveSuperPosition_ExistingSP() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [retrievedSP, existingSPAddress, "Should return existing super position address"]
      👁️  Def: internal
```
