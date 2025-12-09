# Function: test_UpdatePPS_UsesUpTokenForUpkeep()

**Contract**: [test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol/contract_UpdatePPSUpkeepIntegrationTest.md]

## Metadata

- **Contract**: UpdatePPSUpkeepIntegrationTest
- **Signature**: `test_UpdatePPS_UsesUpTokenForUpkeep()`
- **Visibility**: public
- **Source Range**: 10577:2989:583

## Implementation

```solidity
/// @notice Test that upkeep token is used for upkeep when updatePPS is called
function test_UpdatePPS_UsesUpTokenForUpkeep() public {
    uint256 upkeepCost = governor.getUpkeepCostPerSingleUpdate(address(ecdsaOracle));
    console2.log("Upkeep cost per entry (in upkeep tokens):", upkeepCost);
    assertGt(upkeepCost, 0, "Upkeep cost should be > 0");
    uint256 depositAmount = upkeepCost * 10;
    vm.prank(deployer);
    upToken.mint(manager, depositAmount);
    vm.startPrank(manager);
    upToken.approve(address(aggregator), depositAmount);
    aggregator.depositUpkeep(strategy, depositAmount);
    vm.stopPrank();
    uint256 initialStrategyUpkeep = aggregator.getUpkeepBalance(strategy);
    uint256 initialClaimableUpkeep = aggregator.claimableUpkeep();
    console2.log("Initial strategy upkeep balance:", initialStrategyUpkeep);
    console2.log("Initial claimable upkeep:", initialClaimableUpkeep);
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
    uint256 finalStrategyUpkeep = aggregator.getUpkeepBalance(strategy);
    uint256 finalClaimableUpkeep = aggregator.claimableUpkeep();
    console2.log("Final strategy upkeep balance:", finalStrategyUpkeep);
    console2.log("Final claimable upkeep:", finalClaimableUpkeep);
    console2.log("Upkeep deducted from strategy:", initialStrategyUpkeep - finalStrategyUpkeep);
    console2.log("Upkeep added to claimable:", finalClaimableUpkeep - initialClaimableUpkeep);
    assertEq(initialStrategyUpkeep - finalStrategyUpkeep, upkeepCost, "Strategy upkeep should decrease by upkeep cost");
    assertEq(finalClaimableUpkeep - initialClaimableUpkeep, upkeepCost, "Claimable upkeep should increase by upkeep cost");
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

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

- **SuperGovernor::getUpkeepCostPerSingleUpdate(address)**
- **Vm::prank(address)**
- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockUp::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **SuperVaultAggregator::claimableUpkeep()**
- **Vm::warp(uint256)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **deployer** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]
- **manager** (`address`)
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **PPS** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **validator1** (`address`)
- **validator2** (`address`)
- **validator1PrivateKey** (`uint256`)
- **validator2PrivateKey** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest.test_UpdatePPS_UsesUpTokenForUpkeep() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["Upkeep cost per entry (in upkeep tokens):", upkeepCost]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [upkeepCost, 0, "Upkeep cost should be > 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 5)
  │   💬 Args: ["Initial strategy upkeep balance:", initialStrategyUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 6)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 7)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 8)
  │   💬 Args: ["Initial claimable upkeep:", initialClaimableUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._createValidProofs(address,uint256,uint256) (NodeID: 11)
  │   💬 Args: [strategy, PPS, block.timestamp]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._getDigest(address,uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [_strategy, _pps, _timestamp, nonce]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 13)
  │ │   💬 Args: [validator1PrivateKey, digest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 14)
  │ │   💬 Args: [validator2PrivateKey, digest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 15)
  │ │   💬 Args: [validator2PrivateKey, digest]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._sign(uint256,bytes32) (NodeID: 16)
  │     💬 Args: [validator1PrivateKey, digest]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 17)
  │   💬 Args: ["Final strategy upkeep balance:", finalStrategyUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 20)
  │   💬 Args: ["Final claimable upkeep:", finalClaimableUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 23)
  │   💬 Args: ["Upkeep deducted from strategy:", initialStrategyUpkeep - finalStrategyUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 26)
  │   💬 Args: ["Upkeep added to claimable:", finalClaimableUpkeep - initialClaimableUpkeep]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 27)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 28)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 29)
  │   💬 Args: [initialStrategyUpkeep - finalStrategyUpkeep, upkeepCost, "Strategy upkeep should decrease by upkeep cost"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 30)
      💬 Args: [finalClaimableUpkeep - initialClaimableUpkeep, upkeepCost, "Claimable upkeep should increase by upkeep cost"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that upkeep token is used for upkeep when updatePPS is called
