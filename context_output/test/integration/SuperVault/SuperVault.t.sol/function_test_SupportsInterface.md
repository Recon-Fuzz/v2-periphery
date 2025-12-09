# Function: test_SupportsInterface()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SupportsInterface()`
- **Visibility**: public
- **Source Range**: 64797:956:580

## Implementation

```solidity
function test_SupportsInterface() public view {
    bytes4 erc7540RedeemId = type(IERC7540Redeem).interfaceId;
    assertTrue(vault.supportsInterface(erc7540RedeemId), "Should support ERC7540Redeem");
    bytes4 erc7741Id = type(IERC7741).interfaceId;
    assertTrue(vault.supportsInterface(erc7741Id), "Should support ERC7741");
    bytes4 erc4626Id = type(IERC4626).interfaceId;
    assertTrue(vault.supportsInterface(erc4626Id), "Should support ERC4626");
    bytes4 erc165Id = type(IERC165).interfaceId;
    assertTrue(vault.supportsInterface(erc165Id), "Should support ERC165");
    bytes4 randomId = bytes4(keccak256("random"));
    assertFalse(vault.supportsInterface(randomId), "Should not support random interface");
}
```

## Related Implementations

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

## External Calls

- **SuperVault::supportsInterface(bytes4)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SupportsInterface() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [vault.supportsInterface(erc7540RedeemId), "Should support ERC7540Redeem"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [vault.supportsInterface(erc7741Id), "Should support ERC7741"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
  │   💬 Args: [vault.supportsInterface(erc4626Id), "Should support ERC4626"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [vault.supportsInterface(erc165Id), "Should support ERC165"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 5)
      💬 Args: [vault.supportsInterface(randomId), "Should not support random interface"]
      👁️  Def: internal
```
