# Function: test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient()`
- **Visibility**: public
- **Source Range**: 128162:1701:660

## Implementation

```solidity
/// @notice Tests executeVaultFeeConfigUpdate reverts when proposed recipient is zero address
///  @dev Covers SuperVaultStrategy.sol:511
///  @dev This is a defensive check since proposeFeeConfigUpdate already validates recipient != 0
function test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient() public {
    bytes32 effectiveTimeSlot = bytes32(uint256(9));
    vm.store(address(strategy), effectiveTimeSlot, bytes32(uint256(1)));
    bytes32 proposedFeesSlot = bytes32(uint256(6));
    uint256 packedFees = (uint256(500) << 16) | uint256(1000);
    vm.store(address(strategy), proposedFeesSlot, bytes32(packedFees));
    bytes32 proposedRecipientSlot = bytes32(uint256(7));
    vm.store(address(strategy), proposedRecipientSlot, bytes32(uint256(0)));
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    strategy.executeVaultFeeConfigUpdate();
}
```

## External Calls

- **Vm::store(address,bytes32,bytes32)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::executeVaultFeeConfigUpdate()**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests executeVaultFeeConfigUpdate reverts when proposed recipient is zero address
 @dev Covers SuperVaultStrategy.sol:511
 @dev This is a defensive check since proposeFeeConfigUpdate already validates recipient != 0
