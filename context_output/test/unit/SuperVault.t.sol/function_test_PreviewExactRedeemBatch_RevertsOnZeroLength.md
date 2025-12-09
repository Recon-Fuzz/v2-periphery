# Function: test_PreviewExactRedeemBatch_RevertsOnZeroLength()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_PreviewExactRedeemBatch_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 186055:390:660

## Implementation

```solidity
/// @notice Tests previewExactRedeemBatch reverts when controllers array is empty
///  @dev Covers SuperVaultStrategy.sol:687
function test_PreviewExactRedeemBatch_RevertsOnZeroLength() public {
    address[] memory controllers = new address[](0);
    vm.expectRevert(ISuperVaultStrategy.ZERO_LENGTH.selector);
    strategy.previewExactRedeemBatch(controllers);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::previewExactRedeemBatch(address[])**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_PreviewExactRedeemBatch_RevertsOnZeroLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests previewExactRedeemBatch reverts when controllers array is empty
 @dev Covers SuperVaultStrategy.sol:687
