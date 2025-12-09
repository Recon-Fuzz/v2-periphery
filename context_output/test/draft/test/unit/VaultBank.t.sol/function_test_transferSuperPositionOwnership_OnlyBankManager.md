# Function: test_transferSuperPositionOwnership_OnlyBankManager()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_transferSuperPositionOwnership_OnlyBankManager()`
- **Visibility**: public
- **Source Range**: 64268:799:570

## Implementation

```solidity
function test_transferSuperPositionOwnership_OnlyBankManager() public {
    VaultBankSuperPosition testSP = new VaultBankSuperPosition("TestSP", "TSP", 18, yieldSourceOracleId);
    address newOwner = address(0x9999);
    assertEq(testSP.owner(), address(this), "Initial owner should be test contract");
    vm.startPrank(user);
    vm.expectRevert(IVaultBank.INVALID_BANK_MANAGER.selector);
    vaultBank.transferSuperPositionOwnership(address(testSP), newOwner);
    vm.stopPrank();
    assertEq(testSP.owner(), address(this), "Owner should not have changed");
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

- **VaultBankSuperPosition::owner()**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::transferSuperPositionOwnership(address,address)**
- **Vm::stopPrank()**

## State Variable Reads

- **yieldSourceOracleId** (`bytes32`)
- **user** (`address`)
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_transferSuperPositionOwnership_OnlyBankManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [testSP.owner(), address(this), "Initial owner should be test contract"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [testSP.owner(), address(this), "Owner should not have changed"]
      👁️  Def: internal
```
