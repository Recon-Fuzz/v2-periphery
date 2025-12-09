# Function: test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success()`
- **Visibility**: public
- **Source Range**: 98802:724:659

## Implementation

```solidity
/// @notice Tests setOracleFeedMaxStaleness with valid staleness value
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success() public {
    MockSuperOracleForStaleness mockOracle = new MockSuperOracleForStaleness();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracle));
    address feed = address(0x123);
    uint256 validStaleness = 500;
    vm.prank(oracleManager);
    superGovernor.setOracleFeedMaxStaleness(feed, validStaleness);
    assertEq(mockOracle.lastFeed(), feed, "Oracle should have received the feed address");
    assertEq(mockOracle.lastFeedStaleness(), validStaleness, "Oracle should have received the staleness value");
}
```

## Related Implementations

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
- **SuperGovernor::setOracleFeedMaxStaleness(address,uint256)**
- **MockSuperOracleForStaleness::lastFeed()**
- **MockSuperOracleForStaleness::lastFeedStaleness()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [mockOracle.lastFeed(), feed, "Oracle should have received the feed address"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [mockOracle.lastFeedStaleness(), validStaleness, "Oracle should have received the staleness value"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setOracleFeedMaxStaleness with valid staleness value
