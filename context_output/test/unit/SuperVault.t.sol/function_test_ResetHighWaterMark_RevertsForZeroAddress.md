# Function: test_ResetHighWaterMark_RevertsForZeroAddress()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ResetHighWaterMark_RevertsForZeroAddress()`
- **Visibility**: public
- **Source Range**: 223312:220:660

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark reverts for invalid (zero address) strategy
function test_ResetHighWaterMark_RevertsForZeroAddress() public {
    vm.prank(sGovernor);
    vm.expectRevert(ISuperGovernor.INVALID_ADDRESS.selector);
    superGovernor.resetHighWaterMark(address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ResetHighWaterMark_RevertsForZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark reverts for invalid (zero address) strategy
