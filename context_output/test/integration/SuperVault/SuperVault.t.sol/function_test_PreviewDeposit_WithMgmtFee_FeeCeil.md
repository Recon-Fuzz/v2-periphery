# Function: test_PreviewDeposit_WithMgmtFee_FeeCeil()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_PreviewDeposit_WithMgmtFee_FeeCeil()`
- **Visibility**: public
- **Source Range**: 407385:453:580

## Implementation

```solidity
/// @notice Test that previewDeposit reflects entry fee precisely (ceil on fee)
function test_PreviewDeposit_WithMgmtFee_FeeCeil() public {
    _setFeeConfig(100, 100, TREASURY);
    uint256 tiny = 1;
    uint256 expectedShares = vault.convertToShares(0);
    assertEq(vault.previewDeposit(tiny), expectedShares, "fee rounds up");
}
```

## Related Implementations

### _setFeeConfig(uint256,uint256,address)

- **Kind**: internal
- **Source**: 106339:359:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_setFeeConfig(uint256,uint256,address)`

```solidity
function _setFeeConfig(uint256 performanceFeeBps, uint256 managementFeeBps, address feeRecipient) internal {
    vm.startPrank(MANAGER);
    strategy.proposeVaultFeeConfigUpdate(performanceFeeBps, managementFeeBps, feeRecipient);
    vm.warp(block.timestamp + 1 weeks);
    strategy.executeVaultFeeConfigUpdate();
    vm.stopPrank();
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVault::convertToShares(uint256)**
- **SuperVault::previewDeposit(uint256)**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_PreviewDeposit_WithMgmtFee_FeeCeil() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._setFeeConfig(uint256,uint256,address) (NodeID: 1)
  │   💬 Args: [100, 100, TREASURY]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [vault.previewDeposit(tiny), expectedShares, "fee rounds up"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that previewDeposit reflects entry fee precisely (ceil on fee)
