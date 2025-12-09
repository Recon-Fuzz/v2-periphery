# Function: test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient()`
- **Visibility**: public
- **Source Range**: 98074:283:661

## Implementation

```solidity
function test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient() public {
    vm.prank(secondaryManager);
    vm.expectRevert(ISuperVaultAggregator.ZERO_ADDRESS.selector);
    superVaultAggregator.proposeChangePrimaryManager(strategy, manager, address(0));
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
- **manager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
