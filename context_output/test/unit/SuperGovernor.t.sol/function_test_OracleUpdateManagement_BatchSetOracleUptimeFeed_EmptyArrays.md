# Function: test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 125757:671:659

## Implementation

```solidity
/// @notice Tests batchSetOracleUptimeFeed with empty arrays
///  @dev Tests edge case with empty input arrays
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays() public {
    MockSuperOracleL2 mockOracleL2 = new MockSuperOracleL2();
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(mockOracleL2));
    address[] memory dataOracles = new address[](0);
    address[] memory uptimeOracles = new address[](0);
    uint256[] memory gracePeriods = new uint256[](0);
    vm.prank(oracleManager);
    superGovernor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
}
```

## External Calls

- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::batchSetOracleUptimeFeed(address[],address[],uint256[])**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests batchSetOracleUptimeFeed with empty arrays
 @dev Tests edge case with empty input arrays
