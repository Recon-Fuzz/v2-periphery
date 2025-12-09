# Function: test_UpdatePPSExpiration_SucceedsAfterTimelock()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_UpdatePPSExpiration_SucceedsAfterTimelock()`
- **Visibility**: public
- **Source Range**: 136994:506:660

## Implementation

```solidity
/// @notice Tests updatePPSExpiration succeeds after timelock passes
///  @dev Covers SuperVaultStrategy.sol:912-915
function test_UpdatePPSExpiration_SucceedsAfterTimelock() public {
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.warp((block.timestamp + 1 weeks) + 1);
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::warp(uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_UpdatePPSExpiration_SucceedsAfterTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests updatePPSExpiration succeeds after timelock passes
 @dev Covers SuperVaultStrategy.sol:912-915
