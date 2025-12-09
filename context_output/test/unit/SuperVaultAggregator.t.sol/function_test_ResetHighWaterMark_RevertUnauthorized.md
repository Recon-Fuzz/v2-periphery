# Function: test_ResetHighWaterMark_RevertUnauthorized()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ResetHighWaterMark_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 42928:238:661

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark reverts when caller is not SuperGovernor
function test_ResetHighWaterMark_RevertUnauthorized() public {
    vm.prank(user);
    vm.expectRevert(ISuperVaultAggregator.UNAUTHORIZED_UPDATE_AUTHORITY.selector);
    superVaultAggregator.resetHighWaterMark(strategy);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::resetHighWaterMark(address)**

## State Variable Reads

- **user** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ResetHighWaterMark_RevertUnauthorized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark reverts when caller is not SuperGovernor
