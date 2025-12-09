# Function: test_OracleUpdateManagement_CompleteFlow()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_CompleteFlow()`
- **Visibility**: public
- **Source Range**: 127259:1657:659

## Implementation

```solidity
/// @notice Tests the complete flow: queue then execute oracle update
function test_OracleUpdateManagement_CompleteFlow() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory bases = new address[](3);
    bases[0] = address(0x111);
    bases[1] = address(0x222);
    bases[2] = address(0x333);
    address[] memory quotes = new address[](3);
    quotes[0] = address(0x444);
    quotes[1] = address(0x555);
    quotes[2] = address(0x666);
    bytes32[] memory providers = new bytes32[](3);
    providers[0] = keccak256("PROVIDER1");
    providers[1] = keccak256("PROVIDER2");
    providers[2] = keccak256("PROVIDER3");
    address[] memory feeds = new address[](3);
    feeds[0] = address(0x777);
    feeds[1] = address(0x888);
    feeds[2] = address(0x999);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    assertTrue(mockOracle.oracleUpdateQueued(), "Oracle update should be queued");
    assertEq(mockOracle.getLastBasesLength(), 3, "Should have 3 bases");
    assertEq(mockOracle.getLastProvider(2), providers[2], "Third provider should match");
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

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 4521:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
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
- **MockSuperOracleForStaleness::getLastProvider(uint256)**
- **SuperGovernor::executeOracleUpdate()**
- **MockSuperOracleForStaleness::oracleUpdateExecuted()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_CompleteFlow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockOracle.oracleUpdateQueued(), "Oracle update should be queued"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [mockOracle.getLastBasesLength(), 3, "Should have 3 bases"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 3)
  │   💬 Args: [mockOracle.getLastProvider(2), providers[2], "Third provider should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
      💬 Args: [mockOracle.oracleUpdateExecuted(), "Oracle update should be executed"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests the complete flow: queue then execute oracle update
