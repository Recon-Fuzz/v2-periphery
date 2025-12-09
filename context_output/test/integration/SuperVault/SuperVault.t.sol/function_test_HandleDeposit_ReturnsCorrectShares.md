# Function: test_HandleDeposit_ReturnsCorrectShares()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_HandleDeposit_ReturnsCorrectShares()`
- **Visibility**: public
- **Source Range**: 14412:498:580

## Implementation

```solidity
function test_HandleDeposit_ReturnsCorrectShares() public {
    uint256 depositAmount = 1000e6;
    uint256 expectedShares = vault.previewDeposit(depositAmount);
    vm.expectRevert(ISuperVaultStrategy.ACCESS_DENIED.selector);
    strategy.handleOperations4626Deposit(accountEth, depositAmount);
    vm.prank(address(vault));
    uint256 shares = strategy.handleOperations4626Deposit(accountEth, depositAmount);
    assertEq(shares, expectedShares);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **SuperVault::previewDeposit(uint256)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::handleOperations4626Deposit(address,uint256)**
- **Vm::prank(address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_HandleDeposit_ReturnsCorrectShares() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
      💬 Args: [shares, expectedShares]
      👁️  Def: internal
```
