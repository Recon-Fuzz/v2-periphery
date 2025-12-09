# Function: test_AddressRegistry_SetAndGetAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_AddressRegistry_SetAndGetAddress()`
- **Visibility**: public
- **Source Range**: 18688:338:659

## Implementation

```solidity
/// @notice Tests setting and getting an address.
function test_AddressRegistry_SetAndGetAddress() public {
    vm.prank(sGovernor);
    vm.expectEmit(true, true, true, true);
    emit ISuperGovernor.AddressSet(TEST_KEY, address(0), user);
    superGovernor.setAddress(TEST_KEY, user);
    assertEq(superGovernor.getAddress(TEST_KEY), user, "Address mismatch");
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

- **Vm::prank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::getAddress(bytes32)**

## State Variable Reads

- **sGovernor** (`address`)
- **TEST_KEY** (`bytes32`)
- **user** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_AddressRegistry_SetAndGetAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
      💬 Args: [superGovernor.getAddress(TEST_KEY), user, "Address mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setting and getting an address.
