# Function: test_ProposePPSExpiration_RevertsOnThresholdTooLow()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_RevertsOnThresholdTooLow()`
- **Visibility**: public
- **Source Range**: 130865:363:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is below minimum
///  @dev Covers SuperVaultStrategy.sol:892 - MIN_PPS_EXPIRATION_THRESHOLD = 1 minute
function test_ProposePPSExpiration_RevertsOnThresholdTooLow() public {
    uint256 tooLowThreshold = 30 seconds;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS_EXPIRY_THRESHOLD.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, tooLowThreshold);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_RevertsOnThresholdTooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration reverts when threshold is below minimum
 @dev Covers SuperVaultStrategy.sol:892 - MIN_PPS_EXPIRATION_THRESHOLD = 1 minute
