# Function: test_constructor()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_constructor()`
- **Visibility**: public
- **Source Range**: 53017:794:570

## Implementation

```solidity
function test_constructor() public {
    address newGovernor = address(0xABCD);
    address newRegistry = address(0xDCBA);
    VaultBank newVaultBank = new VaultBank(newGovernor, newRegistry);
    assertEq(address(newVaultBank.SUPER_GOVERNOR()), newGovernor, "SUPER_GOVERNOR should be set to the provided governor address");
    assertEq(address(newVaultBank.SUPER_REGISTRY()), newRegistry, "SUPER_REGISTRY should be set to the provided registry address");
    vm.expectRevert(IVaultBank.INVALID_VALUE.selector);
    new VaultBank(address(0), newRegistry);
    vm.expectRevert(IVaultBank.INVALID_VALUE.selector);
    new VaultBank(newGovernor, address(0));
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

- **VaultBank::SUPER_GOVERNOR()**
- **VaultBank::SUPER_REGISTRY()**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [address(newVaultBank.SUPER_GOVERNOR()), newGovernor, "SUPER_GOVERNOR should be set to the provided governor address"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [address(newVaultBank.SUPER_REGISTRY()), newRegistry, "SUPER_REGISTRY should be set to the provided registry address"]
      👁️  Def: internal
```
