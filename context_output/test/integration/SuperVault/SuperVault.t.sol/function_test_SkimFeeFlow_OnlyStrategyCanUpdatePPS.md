# Function: test_SkimFeeFlow_OnlyStrategyCanUpdatePPS()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SkimFeeFlow_OnlyStrategyCanUpdatePPS()`
- **Visibility**: public
- **Source Range**: 491768:415:580

## Implementation

```solidity
/// @notice Test access control - only registered strategy can call updatePPSAfterSkim
function test_SkimFeeFlow_OnlyStrategyCanUpdatePPS() public {
    uint256 newPPS = 1e18;
    uint256 feeAmount = 100e6;
    vm.expectRevert(ISuperVaultAggregator.UNKNOWN_STRATEGY.selector);
    aggregator.updatePPSAfterSkim(newPPS, feeAmount);
    console2.log("Access control test passed");
}
```

## Related Implementations

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

- **Vm::expectRevert(bytes4)**
- **SuperVaultAggregator::updatePPSAfterSkim(uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SkimFeeFlow_OnlyStrategyCanUpdatePPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
      💬 Args: ["Access control test passed"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test access control - only registered strategy can call updatePPSAfterSkim
