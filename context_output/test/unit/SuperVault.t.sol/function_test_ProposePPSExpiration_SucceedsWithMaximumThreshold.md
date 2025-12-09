# Function: test_ProposePPSExpiration_SucceedsWithMaximumThreshold()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_SucceedsWithMaximumThreshold()`
- **Visibility**: public
- **Source Range**: 132807:305:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration succeeds with maximum threshold
///  @dev Covers edge case at MAX_PPS_EXPIRATION_THRESHOLD
function test_ProposePPSExpiration_SucceedsWithMaximumThreshold() public {
    uint256 maxThreshold = 1 weeks;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, maxThreshold);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_SucceedsWithMaximumThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration succeeds with maximum threshold
 @dev Covers edge case at MAX_PPS_EXPIRATION_THRESHOLD
