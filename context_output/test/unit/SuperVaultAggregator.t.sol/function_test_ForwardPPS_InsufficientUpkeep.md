# Function: test_ForwardPPS_InsufficientUpkeep()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ForwardPPS_InsufficientUpkeep()`
- **Visibility**: public
- **Source Range**: 110102:1904:661

## Implementation

```solidity
function test_ForwardPPS_InsufficientUpkeep() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    vm.prank(sGovernor);
    superGovernor.proposeUpkeepPaymentsChange(true);
    vm.warp(block.timestamp + 1 weeks);
    vm.prank(sGovernor);
    superGovernor.executeUpkeepPaymentsChange();
    uint256 lastUpdateTimestamp = superVaultAggregator.getLastUpdateTimestamp(strategy);
    address[] memory strategies = new address[](1);
    strategies[0] = strategy;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = 1e18;
    uint256[] memory timestamps = new uint256[](1);
    address[] memory updateAuthorities = new address[](1);
    updateAuthorities[0] = user;
    vm.warp((lastUpdateTimestamp + 65) + 1 weeks);
    timestamps[0] = block.timestamp - 100;
    uint256 upkeepCost = superGovernor.getUpkeepCostPerSingleUpdate(address(this));
    uint256 upkeepBalance = superVaultAggregator.getUpkeepBalance(strategy);
    console2.log("upkeepCost", upkeepCost);
    console2.log("upkeepBalance", upkeepBalance);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.StrategyPaused(strategy);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.StrategyPPSStale(strategy);
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.InsufficientUpkeep(strategy, strategy, upkeepBalance, upkeepCost);
    superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
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

## External Calls

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperGovernor::proposeUpkeepPaymentsChange(bool)**
- **Vm::warp(uint256)**
- **SuperGovernor::executeUpkeepPaymentsChange()**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **SuperGovernor::getUpkeepCostPerSingleUpdate(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **user** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ForwardPPS_InsufficientUpkeep() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["upkeepCost", upkeepCost]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 4)
      💬 Args: ["upkeepBalance", upkeepBalance]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
        💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
