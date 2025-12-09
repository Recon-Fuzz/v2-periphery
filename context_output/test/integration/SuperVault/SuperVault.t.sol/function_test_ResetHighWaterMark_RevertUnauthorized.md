# Function: test_ResetHighWaterMark_RevertUnauthorized()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ResetHighWaterMark_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 409814:205:580

## Implementation

```solidity
function test_ResetHighWaterMark_RevertUnauthorized() public {
    vm.prank(user1);
    vm.expectRevert(ISuperVaultStrategy.ACCESS_DENIED.selector);
    strategy.resetHighWaterMark(1e18);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::resetHighWaterMark(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ResetHighWaterMark_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
