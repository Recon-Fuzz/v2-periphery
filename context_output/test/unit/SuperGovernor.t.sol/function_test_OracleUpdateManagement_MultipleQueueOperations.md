# Function: test_OracleUpdateManagement_MultipleQueueOperations()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_MultipleQueueOperations()`
- **Visibility**: public
- **Source Range**: 128998:2096:659

## Implementation

```solidity
/// @notice Tests multiple queue operations (should overwrite previous)
function test_OracleUpdateManagement_MultipleQueueOperations() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address[] memory bases1 = new address[](1);
    bases1[0] = address(0x111);
    address[] memory quotes1 = new address[](1);
    quotes1[0] = address(0x333);
    bytes32[] memory providers1 = new bytes32[](1);
    providers1[0] = keccak256("PROVIDER1");
    address[] memory feeds1 = new address[](1);
    feeds1[0] = address(0x555);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases1, quotes1, providers1, feeds1);
    address[] memory bases2 = new address[](2);
    bases2[0] = address(0x222);
    bases2[1] = address(0x333);
    address[] memory quotes2 = new address[](2);
    quotes2[0] = address(0x444);
    quotes2[1] = address(0x555);
    bytes32[] memory providers2 = new bytes32[](2);
    providers2[0] = keccak256("PROVIDER2");
    providers2[1] = keccak256("PROVIDER3");
    address[] memory feeds2 = new address[](2);
    feeds2[0] = address(0x666);
    feeds2[1] = address(0x777);
    vm.prank(oracleManager);
    superGovernor.queueOracleUpdate(bases2, quotes2, providers2, feeds2);
    assertTrue(mockOracle.oracleUpdateQueued(), "Oracle update should be queued");
    assertEq(mockOracle.getLastBasesLength(), 2, "Should have 2 bases from second operation");
    assertEq(mockOracle.getLastBase(0), bases2[0], "First base should be from second operation");
    assertEq(mockOracle.getLastBase(1), bases2[1], "Second base should be from second operation");
    assertEq(mockOracle.getLastProvider(0), providers2[0], "First provider should be from second operation");
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
- **MockSuperOracleForStaleness::getLastBase(uint256)**
- **MockSuperOracleForStaleness::getLastProvider(uint256)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_MultipleQueueOperations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [mockOracle.oracleUpdateQueued(), "Oracle update should be queued"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [mockOracle.getLastBasesLength(), 2, "Should have 2 bases from second operation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [mockOracle.getLastBase(0), bases2[0], "First base should be from second operation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [mockOracle.getLastBase(1), bases2[1], "Second base should be from second operation"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 5)
      💬 Args: [mockOracle.getLastProvider(0), providers2[0], "First provider should be from second operation"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests multiple queue operations (should overwrite previous)
