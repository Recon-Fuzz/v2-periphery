# Function: test_SkimFeeFlow_OnlyManagerCanSkim()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SkimFeeFlow_OnlyManagerCanSkim()`
- **Visibility**: public
- **Source Range**: 468211:276:580

## Implementation

```solidity
/// @notice Test 4.1: Only manager can skim fees
function test_SkimFeeFlow_OnlyManagerCanSkim() public {
    address nonManager = address(0x9999);
    vm.startPrank(nonManager);
    vm.expectRevert();
    strategy.skimPerformanceFee();
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert()**
- **SuperVaultStrategy::skimPerformanceFee()**
- **Vm::stopPrank()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SkimFeeFlow_OnlyManagerCanSkim() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Test 4.1: Only manager can skim fees
