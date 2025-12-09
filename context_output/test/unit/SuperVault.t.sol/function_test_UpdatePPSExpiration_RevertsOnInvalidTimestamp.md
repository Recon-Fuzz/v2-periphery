# Function: test_UpdatePPSExpiration_RevertsOnInvalidTimestamp()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_UpdatePPSExpiration_RevertsOnInvalidTimestamp()`
- **Visibility**: public
- **Source Range**: 135414:555:660

## Implementation

```solidity
/// @notice Tests updatePPSExpiration reverts when called before effective time
///  @dev Covers SuperVaultStrategy.sol:908
function test_UpdatePPSExpiration_RevertsOnInvalidTimestamp() public {
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_TIMESTAMP.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_UpdatePPSExpiration_RevertsOnInvalidTimestamp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests updatePPSExpiration reverts when called before effective time
 @dev Covers SuperVaultStrategy.sol:908
