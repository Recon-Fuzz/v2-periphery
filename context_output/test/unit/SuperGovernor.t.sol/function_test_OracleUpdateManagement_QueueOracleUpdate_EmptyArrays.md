# Function: test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 111704:1116:659

## Implementation

```solidity
/// @notice Tests queueOracleUpdate with empty arrays
function test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory bases = new address[](0);
    address[] memory quotes = new address[](0);
    bytes32[] memory providers = new bytes32[](0);
    address[] memory feeds = new address[](0);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    assertTrue(mockOracle.oracleUpdateQueued(), "Oracle update should be queued");
    assertEq(mockOracle.getLastBasesLength(), 0, "Should have 0 bases");
    assertEq(mockOracle.getLastQuotesLength(), 0, "Should have 0 quotes");
    assertEq(mockOracle.getLastProvidersLength(), 0, "Should have 0 providers");
    assertEq(mockOracle.getLastFeedsLength(), 0, "Should have 0 feeds");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **MockSuperOracleForStaleness::oracleUpdateQueued()**
- **MockSuperOracleForStaleness::getLastBasesLength()**
- **MockSuperOracleForStaleness::getLastQuotesLength()**
- **MockSuperOracleForStaleness::getLastProvidersLength()**
- **MockSuperOracleForStaleness::getLastFeedsLength()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockOracle.oracleUpdateQueued(), "Oracle update should be queued"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [mockOracle.getLastBasesLength(), 0, "Should have 0 bases"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [mockOracle.getLastQuotesLength(), 0, "Should have 0 quotes"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [mockOracle.getLastProvidersLength(), 0, "Should have 0 providers"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [mockOracle.getLastFeedsLength(), 0, "Should have 0 feeds"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests queueOracleUpdate with empty arrays
