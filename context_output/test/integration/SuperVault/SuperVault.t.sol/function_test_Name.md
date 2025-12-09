# Function: test_Name()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_Name()`
- **Visibility**: public
- **Source Range**: 9371:121:580

## Implementation

```solidity
function test_Name() public view {
    string memory name = vault.name();
    assertEq(name, "SuperVault");
}
```

## Related Implementations

### assertEq(string,string)

- **Kind**: internal
- **Source**: 5050:122:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **SuperVault::name()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_Name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 1)
      💬 Args: [name, "SuperVault"]
      👁️  Def: internal
```
