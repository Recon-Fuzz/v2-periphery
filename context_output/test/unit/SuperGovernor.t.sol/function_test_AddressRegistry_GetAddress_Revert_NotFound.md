# Function: test_AddressRegistry_GetAddress_Revert_NotFound()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_AddressRegistry_GetAddress_Revert_NotFound()`
- **Visibility**: public
- **Source Range**: 20060:203:659

## Implementation

```solidity
/// @notice Tests reverting when getting a non-existent address.
function test_AddressRegistry_GetAddress_Revert_NotFound() public {
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    superGovernor.getAddress(keccak256("NON_EXISTENT"));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperGovernor::getAddress(bytes32)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_AddressRegistry_GetAddress_Revert_NotFound() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests reverting when getting a non-existent address.
