# Function: test_AddressRegistry_SetAddress_Revert_ZeroAddress()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_AddressRegistry_SetAddress_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 19758:227:659

## Implementation

```solidity
/// @notice Tests reverting when setting address to address(0).
function test_AddressRegistry_SetAddress_Revert_ZeroAddress() public {
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.setAddress(TEST_KEY, address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::setAddress(bytes32,address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **TEST_KEY** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_AddressRegistry_SetAddress_Revert_ZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when setting address to address(0).
