# Function: test_ProposePPSExpiration_RevertsOnMinMinusOne()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_RevertsOnMinMinusOne()`
- **Visibility**: public
- **Source Range**: 133723:338:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is exactly MIN - 1
///  @dev Covers SuperVaultStrategy.sol:892 - boundary test at MIN - 1 second
function test_ProposePPSExpiration_RevertsOnMinMinusOne() public {
    uint256 almostMin = 1 minutes - 1;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS_EXPIRY_THRESHOLD.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, almostMin);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_RevertsOnMinMinusOne() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration reverts when threshold is exactly MIN - 1
 @dev Covers SuperVaultStrategy.sol:892 - boundary test at MIN - 1 second
