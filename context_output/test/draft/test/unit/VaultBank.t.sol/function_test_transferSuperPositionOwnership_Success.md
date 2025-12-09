# Function: test_transferSuperPositionOwnership_Success()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_transferSuperPositionOwnership_Success()`
- **Visibility**: public
- **Source Range**: 65073:908:570

## Implementation

```solidity
function test_transferSuperPositionOwnership_Success() public {
    address mockToken = address(0x9ABC);
    uint64 mockChainId = 6;
    string memory name = "New Token";
    string memory symbol = "NTKN";
    uint8 decimals = 18;
    address testSP = vaultBank.exposed_retrieveSuperPosition(yieldSourceOracleId, mockChainId, mockToken, name, symbol, decimals);
    address newOwner = address(0x9999);
    vaultBank.transferSuperPositionOwnership(address(testSP), newOwner);
    vm.prank(newOwner);
    VaultBankSuperPosition(testSP).acceptOwnership();
    assertEq(VaultBankSuperPosition(testSP).owner(), newOwner, "Owner should have changed to new owner");
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

- **TestVaultBank::exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)**
- **TestVaultBank::transferSuperPositionOwnership(address,address)**
- **Vm::prank(address)**
- **VaultBankSuperPosition::acceptOwnership()**
- **VaultBankSuperPosition::owner()**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **yieldSourceOracleId** (`bytes32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_transferSuperPositionOwnership_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [VaultBankSuperPosition(testSP).owner(), newOwner, "Owner should have changed to new owner"]
      👁️  Def: internal
```
