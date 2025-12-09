# Function: test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne()`
- **Visibility**: public
- **Source Range**: 137683:718:660

## Implementation

```solidity
/// @notice Tests updatePPSExpiration reverts when timestamp is exactly effectiveTime - 1
///  @dev Covers SuperVaultStrategy.sol:908 - boundary test for timestamp check
function test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne() public {
    uint256 proposalTime = block.timestamp;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 2 hours);
    vm.warp((proposalTime + 1 weeks) - 1);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_TIMESTAMP.selector);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::managePPSExpiration(enum ISuperVaultStrategy.PPSExpirationAction,uint256)**
- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests updatePPSExpiration reverts when timestamp is exactly effectiveTime - 1
 @dev Covers SuperVaultStrategy.sol:908 - boundary test for timestamp check
