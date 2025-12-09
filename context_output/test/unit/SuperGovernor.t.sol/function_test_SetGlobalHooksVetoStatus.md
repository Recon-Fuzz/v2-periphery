# Function: test_SetGlobalHooksVetoStatus()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetGlobalHooksVetoStatus()`
- **Visibility**: public
- **Source Range**: 40356:262:659

## Implementation

```solidity
function test_SetGlobalHooksVetoStatus() public {
    vm.prank(guardian);
    superGovernor.setGlobalHooksRootVetoStatus(true);
    bool vetoed = aggregator.isGlobalHooksRootVetoed();
    assertTrue(vetoed, "Global hooks should be vetoed");
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
- **SuperGovernor::setGlobalHooksRootVetoStatus(bool)**
- **SuperVaultAggregator::isGlobalHooksRootVetoed()**

## State Variable Reads

- **guardian** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetGlobalHooksVetoStatus() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [vetoed, "Global hooks should be vetoed"]
      👁️  Def: internal
```
