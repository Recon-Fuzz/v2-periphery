# Function: test_BatchForwardPPS_ArraySize1()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_ArraySize1()`
- **Visibility**: public
- **Source Range**: 193076:3114:661

## Implementation

```solidity
/// @notice Tests batchForwardPPS with array size 1
function test_BatchForwardPPS_ArraySize1() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.warp(block.timestamp + 10);
    address[] memory strategies = new address[](1);
    uint256[] memory ppss = new uint256[](1);
    uint256[] memory timestamps = new uint256[](1);
    strategies[0] = strategy;
    ppss[0] = 1e18 + 1e15;
    timestamps[0] = superVaultAggregator.getLastUpdateTimestamp(strategy) + 20;
    address[] memory updateAuthorities = new address[](1);
    updateAuthorities[0] = user;
    vm.warp(block.timestamp + 25);
    uint256 gasBefore = gasleft();
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    uint256 gasAfter = gasleft();
    uint256 gasUsed = gasBefore - gasAfter;
    console2.log("batchForwardPPS (size 1) gas used:", gasUsed);
    assertEq(superVaultAggregator.getLastUpdateTimestamp(strategy), timestamps[0], "Timestamp not updated correctly");
    bool isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertFalse(isPaused, "Strategy should not be paused after successful update");
    vm.warp(block.timestamp + 100);
    address mainManager = superVaultAggregator.getMainManager(strategy);
    vm.prank(mainManager);
    superVaultAggregator.updateDeviationThreshold(strategy, 1);
    timestamps[0] = block.timestamp;
    ppss[0] = 2e18;
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: user}));
    isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertTrue(isPaused, "Strategy should be paused after invalid update");
    vm.startPrank(mainManager);
    superVaultAggregator.unpauseStrategy(strategy);
    vm.stopPrank();
    isPaused = superVaultAggregator.isStrategyPaused(strategy);
    assertFalse(isPaused, "Strategy should be unpaused after calling unpauseStrategy");
}
```

## Related Implementations

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
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

### assertFalse(bool,string)

- **Kind**: internal
- **Source**: 2179:149:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertFalse(bool,string)`

```solidity
function assertFalse(bool data, string memory err) virtual internal pure {
    if (data) {
        vm.assertFalse(data, err);
    }
}
```

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
- **SuperGovernor::setActivePPSOracle(address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::updateDeviationThreshold(address,uint256)**
- **Vm::startPrank(address)**
- **SuperVaultAggregator::unpauseStrategy(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_ArraySize1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["batchForwardPPS (size 1) gas used:", gasUsed]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategy), timestamps[0], "Timestamp not updated correctly"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 5)
  │   💬 Args: [isPaused, "Strategy should not be paused after successful update"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 6)
  │   💬 Args: [isPaused, "Strategy should be paused after invalid update"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 7)
      💬 Args: [isPaused, "Strategy should be unpaused after calling unpauseStrategy"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests batchForwardPPS with array size 1
