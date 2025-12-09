# Function: test_OracleUpdateManagement_QueueOracleUpdate_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_Success()`
- **Visibility**: public
- **Source Range**: 107591:1568:659

## Implementation

```solidity
/// @notice Tests queueOracleUpdate with valid parameters
function test_OracleUpdateManagement_QueueOracleUpdate_Success() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory bases = new address[](2);
    bases[0] = address(0x111);
    bases[1] = address(0x222);
    address[] memory quotes = new address[](2);
    quotes[0] = address(0x333);
    quotes[1] = address(0x444);
    bytes32[] memory providers = new bytes32[](2);
    providers[0] = keccak256("PROVIDER1");
    providers[1] = keccak256("PROVIDER2");
    address[] memory feeds = new address[](2);
    feeds[0] = address(0x555);
    feeds[1] = address(0x666);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases, quotes, providers, feeds);
    assertTrue(mockOracle.oracleUpdateQueued(), "Oracle update should be queued");
    assertEq(mockOracle.getLastBasesLength(), 2, "Should have 2 bases");
    assertEq(mockOracle.getLastQuotesLength(), 2, "Should have 2 quotes");
    assertEq(mockOracle.getLastProvidersLength(), 2, "Should have 2 providers");
    assertEq(mockOracle.getLastFeedsLength(), 2, "Should have 2 feeds");
    assertEq(mockOracle.getLastBase(0), bases[0], "First base should match");
    assertEq(mockOracle.getLastBase(1), bases[1], "Second base should match");
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
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
- **MockSuperOracleForStaleness::getLastBase(uint256)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_QueueOracleUpdate_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockOracle.oracleUpdateQueued(), "Oracle update should be queued"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [mockOracle.getLastBasesLength(), 2, "Should have 2 bases"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [mockOracle.getLastQuotesLength(), 2, "Should have 2 quotes"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [mockOracle.getLastProvidersLength(), 2, "Should have 2 providers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [mockOracle.getLastFeedsLength(), 2, "Should have 2 feeds"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 6)
  │   💬 Args: [mockOracle.getLastBase(0), bases[0], "First base should match"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 7)
      💬 Args: [mockOracle.getLastBase(1), bases[1], "Second base should match"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests queueOracleUpdate with valid parameters
