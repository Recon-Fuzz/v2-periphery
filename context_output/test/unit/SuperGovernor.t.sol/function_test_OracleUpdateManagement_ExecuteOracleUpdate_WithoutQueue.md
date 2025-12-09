# Function: test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue()`
- **Visibility**: public
- **Source Range**: 126547:632:659

## Implementation

```solidity
/// @notice Tests executeOracleUpdate can be called without queuing first (depends on oracle implementation)
function test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    vm.prank(oracleManager);
    superGovernor.executeOracleUpdate();
    assertTrue(mockOracle.oracleUpdateExecuted(), "Oracle update should be executed");
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

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::executeOracleUpdate()**
- **MockSuperOracleForStaleness::oracleUpdateExecuted()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
      💬 Args: [mockOracle.oracleUpdateExecuted(), "Oracle update should be executed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeOracleUpdate can be called without queuing first (depends on oracle implementation)
