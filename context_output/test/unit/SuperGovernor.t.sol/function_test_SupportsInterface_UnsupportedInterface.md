# Function: test_SupportsInterface_UnsupportedInterface()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SupportsInterface_UnsupportedInterface()`
- **Visibility**: public
- **Source Range**: 11283:261:659

## Implementation

```solidity
/// @notice Tests supportsInterface returns false for unsupported interface
///  @dev Tests with a random interface ID that should not be supported
function test_SupportsInterface_UnsupportedInterface() public view {
    bytes4 randomInterfaceId = bytes4(keccak256("RandomInterface()"));
    assertFalse(superGovernor.supportsInterface(randomInterfaceId), "Should not support random interface");
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

## External Calls

- **SuperGovernor::supportsInterface(bytes4)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SupportsInterface_UnsupportedInterface() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 1)
      💬 Args: [superGovernor.supportsInterface(randomInterfaceId), "Should not support random interface"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests supportsInterface returns false for unsupported interface
 @dev Tests with a random interface ID that should not be supported
