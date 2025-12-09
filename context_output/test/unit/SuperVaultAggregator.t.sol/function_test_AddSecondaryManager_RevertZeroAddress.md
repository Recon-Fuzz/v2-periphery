# Function: test_AddSecondaryManager_RevertZeroAddress()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_AddSecondaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 32339:237:661

## Implementation

```solidity
/// @notice Tests that addSecondaryManager reverts when manager address is zero
function test_AddSecondaryManager_RevertZeroAddress() public {
    vm.prank(manager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    superVaultAggregator.addSecondaryManager(strategy, address(0));
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**

## State Variable Reads

- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_AddSecondaryManager_RevertZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that addSecondaryManager reverts when manager address is zero
