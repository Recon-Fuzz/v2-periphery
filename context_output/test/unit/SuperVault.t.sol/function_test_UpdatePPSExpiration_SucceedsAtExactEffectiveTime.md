# Function: test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime()`
- **Visibility**: public
- **Source Range**: 138581:654:660

## Implementation

```solidity
/// @notice Tests updatePPSExpiration succeeds when timestamp is exactly at effectiveTime
///  @dev Covers SuperVaultStrategy.sol:908 - boundary test (>= should pass)
function test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime() public {
    uint256 proposalTime = block.timestamp;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.warp(proposalTime + 1 weeks);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests updatePPSExpiration succeeds when timestamp is exactly at effectiveTime
 @dev Covers SuperVaultStrategy.sol:908 - boundary test (>= should pass)
