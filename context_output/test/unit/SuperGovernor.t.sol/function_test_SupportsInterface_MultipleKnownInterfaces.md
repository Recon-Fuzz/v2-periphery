# Function: test_SupportsInterface_MultipleKnownInterfaces()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SupportsInterface_MultipleKnownInterfaces()`
- **Visibility**: public
- **Source Range**: 12440:511:659

## Implementation

```solidity
/// @notice Tests supportsInterface with multiple known interfaces
///  @dev Verifies all supported interfaces return true
function test_SupportsInterface_MultipleKnownInterfaces() public view {
    assertTrue(superGovernor.supportsInterface(type(ISuperGovernor).interfaceId), "Should support ISuperGovernor");
    assertTrue(superGovernor.supportsInterface(type(IAccessControl).interfaceId), "Should support IAccessControl");
    assertTrue(superGovernor.supportsInterface(type(IERC165).interfaceId), "Should support IERC165");
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

## External Calls

- **SuperGovernor::supportsInterface(bytes4)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SupportsInterface_MultipleKnownInterfaces() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [superGovernor.supportsInterface(type(ISuperGovernor).interfaceId), "Should support ISuperGovernor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 2)
  │   💬 Args: [superGovernor.supportsInterface(type(IAccessControl).interfaceId), "Should support IAccessControl"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
      💬 Args: [superGovernor.supportsInterface(type(IERC165).interfaceId), "Should support IERC165"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests supportsInterface with multiple known interfaces
 @dev Verifies all supported interfaces return true
