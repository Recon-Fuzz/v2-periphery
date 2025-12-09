# Function: test_ProposePPSExpiration_SucceedsWithMinimumThreshold()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_SucceedsWithMinimumThreshold()`
- **Visibility**: public
- **Source Range**: 132357:307:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration succeeds with minimum threshold
///  @dev Covers edge case at MIN_PPS_EXPIRATION_THRESHOLD
function test_ProposePPSExpiration_SucceedsWithMinimumThreshold() public {
    uint256 minThreshold = 1 minutes;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, minThreshold);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_SucceedsWithMinimumThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration succeeds with minimum threshold
 @dev Covers edge case at MIN_PPS_EXPIRATION_THRESHOLD
