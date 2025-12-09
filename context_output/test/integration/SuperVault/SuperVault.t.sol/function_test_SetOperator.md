# Function: test_SetOperator()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetOperator()`
- **Visibility**: public
- **Source Range**: 63798:806:580

## Implementation

```solidity
function test_SetOperator() public {
    assertFalse(vault.isOperator(accountEth, operator), "Should not be operator initially");
    vm.prank(accountEth);
    vm.expectRevert(ISuperVault.UNAUTHORIZED.selector);
    vault.setOperator(accountEth, true);
    vm.prank(accountEth);
    vault.setOperator(operator, true);
    assertTrue(vault.isOperator(accountEth, operator), "Should be operator after setting");
    vm.prank(accountEth);
    vault.setOperator(operator, false);
    assertFalse(vault.isOperator(accountEth, operator), "Should not be operator after revoking");
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

- **SuperVault::isOperator(address,address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVault::setOperator(address,bool)**

## State Variable Reads

- **operator** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetOperator() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
  │   💬 Args: [vault.isOperator(accountEth, operator), "Should not be operator initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [vault.isOperator(accountEth, operator), "Should be operator after setting"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
      💬 Args: [vault.isOperator(accountEth, operator), "Should not be operator after revoking"]
      👁️  Def: internal
```
