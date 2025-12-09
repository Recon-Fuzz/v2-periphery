# Function: test_ProposeChangePrimaryManager_RevertZeroAddress()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeChangePrimaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 39631:344:661

## Implementation

```solidity
/// @notice Tests that proposeChangePrimaryManager reverts when newManager is zero address
function test_ProposeChangePrimaryManager_RevertZeroAddress() public {
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    superVaultAggregator.proposeChangePrimaryManager(strategy, address(0), treasury);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**

## State Variable Reads

- **secondaryManager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeChangePrimaryManager_RevertZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that proposeChangePrimaryManager reverts when newManager is zero address
