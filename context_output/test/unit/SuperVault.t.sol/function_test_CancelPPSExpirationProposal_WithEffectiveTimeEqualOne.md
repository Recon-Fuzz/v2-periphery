# Function: test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne()`
- **Visibility**: public
- **Source Range**: 143902:922:660

## Implementation

```solidity
/// @notice Tests cancelPPSExpirationProposal with boundary case effectiveTime == 1
///  @dev Covers SuperVaultStrategy.sol:924 - boundary test for non-zero effectiveTime
function test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne() public {
    bytes32 effectiveTimeSlot = bytes32(uint256(11));
    vm.store(address(strategy), effectiveTimeSlot, bytes32(uint256(1)));
    bytes32 proposedThresholdSlot = bytes32(uint256(10));
    vm.store(address(strategy), proposedThresholdSlot, bytes32(uint256(2 hours)));
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Cancel, 0);
}
```

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests cancelPPSExpirationProposal with boundary case effectiveTime == 1
 @dev Covers SuperVaultStrategy.sol:924 - boundary test for non-zero effectiveTime
