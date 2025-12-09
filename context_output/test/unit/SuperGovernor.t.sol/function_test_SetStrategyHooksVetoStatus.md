# Function: test_SetStrategyHooksVetoStatus()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetStrategyHooksVetoStatus()`
- **Visibility**: public
- **Source Range**: 42481:308:659

## Implementation

```solidity
function test_SetStrategyHooksVetoStatus() public {
    vm.prank(guardian);
    superGovernor.setStrategyHooksRootVetoStatus(address(strategy1), true);
    bool vetoed = aggregator.isStrategyHooksRootVetoed(address(strategy1));
    assertTrue(vetoed, "Strategy hooks should be vetoed");
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setStrategyHooksRootVetoStatus(address,bool)**
- **SuperVaultAggregator::isStrategyHooksRootVetoed(address)**

## State Variable Reads

- **guardian** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy1** (`address`)
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetStrategyHooksVetoStatus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [vetoed, "Strategy hooks should be vetoed"]
      👁️  Def: internal
```
