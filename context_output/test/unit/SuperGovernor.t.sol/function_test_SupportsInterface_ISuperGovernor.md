# Function: test_SupportsInterface_ISuperGovernor()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SupportsInterface_ISuperGovernor()`
- **Visibility**: public
- **Source Range**: 10125:240:659

## Implementation

```solidity
/// @notice Tests supportsInterface returns true for ISuperGovernor interface
///  @dev Covers SuperGovernor.sol:849 - ISuperGovernor interface detection
function test_SupportsInterface_ISuperGovernor() public view {
    bytes4 interfaceId = type(ISuperGovernor).interfaceId;
    assertTrue(superGovernor.supportsInterface(interfaceId), "Should support ISuperGovernor interface");
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
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SupportsInterface_ISuperGovernor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.supportsInterface(interfaceId), "Should support ISuperGovernor interface"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests supportsInterface returns true for ISuperGovernor interface
 @dev Covers SuperGovernor.sol:849 - ISuperGovernor interface detection
