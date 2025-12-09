# Function: test_BatchForwardPPS_Revert_MaxStrategiesExceeded()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_Revert_MaxStrategiesExceeded()`
- **Visibility**: public
- **Source Range**: 191744:1270:661

## Implementation

```solidity
/// @notice Tests that batch PPS updates revert when exceeding MAX_STRATEGIES limit
function test_BatchForwardPPS_Revert_MaxStrategiesExceeded() public {
    uint256 strategiesCount = 501;
    address[] memory strategies = new address[](strategiesCount);
    bytes[][] memory proofsArray = new bytes[][](strategiesCount);
    uint256[] memory ppss = new uint256[](strategiesCount);
    uint256[] memory timestamps = new uint256[](strategiesCount);
    for (uint256 i = 0; i < strategiesCount; i++) {
        strategies[i] = address(uint160(i + 1));
        proofsArray[i] = new bytes[](0);
        ppss[i] = 1e18;
        timestamps[i] = block.timestamp;
    }
    vm.expectRevert(IECDSAPPSOracle.MAX_STRATEGIES_EXCEEDED.selector);
    ecdsaPPSOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **ecdsaPPSOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_Revert_MaxStrategiesExceeded() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that batch PPS updates revert when exceeding MAX_STRATEGIES limit
