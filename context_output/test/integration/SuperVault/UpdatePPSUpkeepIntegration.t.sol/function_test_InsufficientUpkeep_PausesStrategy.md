# Function: test_InsufficientUpkeep_PausesStrategy()

**Contract**: [test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol/contract_UpdatePPSUpkeepIntegrationTest.md]

## Metadata

- **Contract**: UpdatePPSUpkeepIntegrationTest
- **Signature**: `test_InsufficientUpkeep_PausesStrategy()`
- **Visibility**: public
- **Source Range**: 14323:1535:583

## Implementation

```solidity
/// @notice Test that insufficient upkeep causes strategy to pause
function test_InsufficientUpkeep_PausesStrategy() public {
    uint256 upkeepCost = governor.getUpkeepCostPerSingleUpdate(address(ecdsaOracle));
    uint256 insufficientAmount = upkeepCost / 2;
    vm.prank(deployer);
    upToken.mint(manager, insufficientAmount);
    vm.startPrank(manager);
    upToken.approve(address(aggregator), insufficientAmount);
    aggregator.depositUpkeep(strategy, insufficientAmount);
    vm.stopPrank();
    vm.warp(block.timestamp + 10);
    bytes[] memory proofs = _createValidProofs(strategy, PPS, block.timestamp);
    address[] memory strategies = new address[](1);
    strategies[0] = strategy;
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    ecdsaOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
    bool isPaused = aggregator.isStrategyPaused(strategy);
    assertTrue(isPaused, "Strategy should be paused due to insufficient upkeep");
}
```

## Related Implementations

### _createValidProofs(address,uint256,uint256)

- **Kind**: internal
- **Source**: 16028:862:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_createValidProofs(address,uint256,uint256)`

```solidity
/// @notice Helper to create valid proofs from validators
///  @dev Proofs must be ordered by signer address in ascending order (ECDSAPPSOracle requirement)
function _createValidProofs(address _strategy, uint256 _pps, uint256 _timestamp) internal view returns (bytes[] memory) {
    uint256 nonce = ecdsaOracle.noncePerStrategy(_strategy);
    bytes32 digest = _getDigest(_strategy, _pps, _timestamp, nonce);
    bytes[] memory proofs = new bytes[](2);
    if (validator1 < validator2) {
        proofs[0] = _sign(validator1PrivateKey, digest);
        proofs[1] = _sign(validator2PrivateKey, digest);
    } else {
        proofs[0] = _sign(validator2PrivateKey, digest);
        proofs[1] = _sign(validator1PrivateKey, digest);
    }
    return proofs;
}
```

### _getDigest(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 16896:512:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_getDigest(address,uint256,uint256,uint256)`

```solidity
function _getDigest(address _strategy, uint256 _pps, uint256 _timestamp, uint256 _nonce) internal view returns (bytes32) {
    bytes32 structHash = keccak256(abi.encodePacked(ecdsaOracle.UPDATE_PPS_TYPEHASH(), _strategy, _pps, _timestamp, _nonce));
    return keccak256(abi.encodePacked("\u0019\u0001", ecdsaOracle.domainSeparator(), structHash));
}
```

### _sign(uint256,bytes32)

- **Kind**: internal
- **Source**: 17414:208:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_sign(uint256,bytes32)`

```solidity
function _sign(uint256 privateKey, bytes32 digest) internal pure returns (bytes memory) {
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
    return abi.encodePacked(r, s, v);
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

- **SuperGovernor::getUpkeepCostPerSingleUpdate(address)**
- **Vm::prank(address)**
- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockUp::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**
- **SuperVaultAggregator::isStrategyPaused(address)**

## State Variable Reads

- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **deployer** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]
- **manager** (`address`)
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **PPS** (`uint256`)
- **validator1** (`address`)
- **validator2** (`address`)
- **validator1PrivateKey** (`uint256`)
- **validator2PrivateKey** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest.test_InsufficientUpkeep_PausesStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._createValidProofs(address,uint256,uint256) (NodeID: 1)
  │   💬 Args: [strategy, PPS, block.timestamp]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._getDigest(address,uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [_strategy, _pps, _timestamp, nonce]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 3)
  │ │   💬 Args: [validator1PrivateKey, digest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 4)
  │ │   💬 Args: [validator2PrivateKey, digest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 5)
  │ │   💬 Args: [validator2PrivateKey, digest]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 6)
  │     💬 Args: [validator1PrivateKey, digest]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 7)
      💬 Args: [isPaused, "Strategy should be paused due to insufficient upkeep"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that insufficient upkeep causes strategy to pause
