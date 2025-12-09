# Function: test_ProposePPSExpiration_RevertsOnZeroThreshold()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_RevertsOnZeroThreshold()`
- **Visibility**: public
- **Source Range**: 133276:275:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is zero
///  @dev Covers SuperVaultStrategy.sol:892 - explicit zero test for lower bound
function test_ProposePPSExpiration_RevertsOnZeroThreshold() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS_EXPIRY_THRESHOLD.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 0);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_RevertsOnZeroThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration reverts when threshold is zero
 @dev Covers SuperVaultStrategy.sol:892 - explicit zero test for lower bound
