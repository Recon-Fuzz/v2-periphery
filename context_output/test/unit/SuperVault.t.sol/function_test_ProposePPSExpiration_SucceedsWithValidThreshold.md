# Function: test_ProposePPSExpiration_SucceedsWithValidThreshold()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ProposePPSExpiration_SucceedsWithValidThreshold()`
- **Visibility**: public
- **Source Range**: 131894:320:660

## Implementation

```solidity
/// @notice Tests proposePPSExpiration succeeds with valid threshold
///  @dev Covers SuperVaultStrategy.sol:897-898
function test_ProposePPSExpiration_SucceedsWithValidThreshold() public {
    uint256 validThreshold = 2 hours;
    vm.prank(manager);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, validThreshold);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ProposePPSExpiration_SucceedsWithValidThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests proposePPSExpiration succeeds with valid threshold
 @dev Covers SuperVaultStrategy.sol:897-898
