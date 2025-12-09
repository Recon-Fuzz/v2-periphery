# Function: test_ProposePPSExpiration_RevertsOnThresholdTooHigh()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_RevertsOnThresholdTooHigh()`
- **Visibility**: public
- **Source Range**: 131404:360:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is above maximum
///  @dev Covers SuperVaultStrategy.sol:892 - MAX_PPS_EXPIRATION_THRESHOLD = 1 week
function test_ProposePPSExpiration_RevertsOnThresholdTooHigh() public {
    uint256 tooHighThreshold = 8 days;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS_EXPIRY_THRESHOLD.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, tooHighThreshold);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_RevertsOnThresholdTooHigh() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration reverts when threshold is above maximum
 @dev Covers SuperVaultStrategy.sol:892 - MAX_PPS_EXPIRATION_THRESHOLD = 1 week
