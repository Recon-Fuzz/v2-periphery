# Function: test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold()`
- **Visibility**: public
- **Source Range**: 136096:768:660

## Implementation

```solidity
/// @notice Tests updatePPSExpiration reverts when no proposal exists
///  @dev Covers SuperVaultStrategy.sol:910
function test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold() public {
    bytes32 effectiveTimeSlot = bytes32(uint256(11));
    vm.store(address(strategy), effectiveTimeSlot, bytes32(uint256(1)));
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS_EXPIRY_THRESHOLD.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
}
```

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests updatePPSExpiration reverts when no proposal exists
 @dev Covers SuperVaultStrategy.sol:910
