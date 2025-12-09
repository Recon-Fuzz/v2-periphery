# Function: test_ChangePrimaryManager_WithZeroAddressFeeRecipient()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangePrimaryManager_WithZeroAddressFeeRecipient()`
- **Visibility**: public
- **Source Range**: 27681:259:659

## Implementation

```solidity
/// @notice Tests changePrimaryManager with zero address as fee recipient
function test_ChangePrimaryManager_WithZeroAddressFeeRecipient() public {
    vm.prank(sGovernor);
    vm.expectRevert();
    superGovernor.changePrimaryManager(strategy1, newManager, address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert()**
- **SuperGovernor::changePrimaryManager(address,address,address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy1** (`address`)
- **newManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangePrimaryManager_WithZeroAddressFeeRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests changePrimaryManager with zero address as fee recipient
