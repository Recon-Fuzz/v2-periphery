# Function: test_BatchForwardPPS_GasScaling()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_BatchForwardPPS_GasScaling()`
- **Visibility**: public
- **Source Range**: 116101:5707:661

## Implementation

```solidity
/// @notice Tests gas scaling of batchForwardPPS with different array sizes
function test_BatchForwardPPS_GasScaling() public {
    vm.prank(sGovernor);
    superGovernor.setActivePPSOracle(address(this));
    address[] memory allStrategies = new address[](10);
    allStrategies[0] = strategy;
    for (uint256 i = 1; i < 10; i++) {
        vm.prank(manager);
        (, address newStrategy, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: manager, secondaryManagers: new address[](0), name: string(abi.encodePacked("Test Vault ", vm.toString(i + 1))), symbol: string(abi.encodePacked("TV", vm.toString(i + 1))), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
        allStrategies[i] = newStrategy;
    }
    vm.warp(block.timestamp + 10);
    uint256[] memory testSizes = new uint256[](5);
    testSizes[0] = 2;
    testSizes[1] = 4;
    testSizes[2] = 6;
    testSizes[3] = 8;
    testSizes[4] = 10;
    uint256[] memory gasUsed = new uint256[](5);
    for (uint256 testIndex = 0; testIndex < testSizes.length; testIndex++) {
        uint256 arraySize = testSizes[testIndex];
        address[] memory strategies = new address[](arraySize);
        uint256[] memory ppss = new uint256[](arraySize);
        uint256[] memory timestamps = new uint256[](arraySize);
        address[] memory updateAuthorities = new address[](arraySize);
        for (uint256 i = 0; i < arraySize; i++) {
            strategies[i] = allStrategies[i];
            ppss[i] = 1e18 + (i * 1e15);
            updateAuthorities[i] = user;
            uint256 currentTimestamp = superVaultAggregator.getLastUpdateTimestamp(allStrategies[i]);
            timestamps[i] = (currentTimestamp + 20) + testIndex;
        }
        vm.warp((block.timestamp + 25) + testIndex);
        uint256 gasBefore = gasleft();
        superVaultAggregator.forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: strategies, ppss: ppss, timestamps: timestamps, updateAuthority: address(this)}));
        uint256 gasAfter = gasleft();
        gasUsed[testIndex] = gasBefore - gasAfter;
        console2.log(string(abi.encodePacked("Array size: ", vm.toString(arraySize))));
        console2.log(string(abi.encodePacked("Gas used: ", vm.toString(gasUsed[testIndex]))));
        for (uint256 i = 0; i < arraySize; i++) {
            assertEq(superVaultAggregator.getLastUpdateTimestamp(strategies[i]), timestamps[i], "Timestamp not updated correctly");
        }
    }
    console2.log("=== Gas Scaling Analysis ===");
    console2.log("Array Size | Gas Used | Gas per Item | Scaling Factor");
    uint256 baseGas = gasUsed[0];
    for (uint256 i = 0; i < testSizes.length; i++) {
        uint256 gasPerItem = gasUsed[i] / testSizes[i];
        uint256 scalingFactor = (gasUsed[i] * 100) / baseGas;
        console2.log(string(abi.encodePacked(vm.toString(testSizes[i]), " | ", vm.toString(gasUsed[i]), " | ", vm.toString(gasPerItem), " | ", vm.toString(scalingFactor), "%")));
    }
    for (uint256 i = 1; i < testSizes.length; i++) {
        uint256 sizeRatio = (testSizes[i] * 100) / testSizes[0];
        uint256 gasRatio = (gasUsed[i] * 100) / gasUsed[0];
        console2.log(string(abi.encodePacked("Size ratio: ", vm.toString(sizeRatio), "% | Gas ratio: ", vm.toString(gasRatio), "%")));
    }
    console2.log("\n=== Conclusion ===");
    console2.log("Gas scaling appears to be roughly linear with array size");
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

- **Vm::prank(address)**
- **SuperGovernor::setActivePPSOracle(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::toString(uint256)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::getLastUpdateTimestamp(address)**
- **SuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_BatchForwardPPS_GasScaling() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: [string(abi.encodePacked("Array size: ", vm.toString(arraySize)))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 4)
  │   💬 Args: [string(abi.encodePacked("Gas used: ", vm.toString(gasUsed[testIndex])))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [superVaultAggregator.getLastUpdateTimestamp(strategies[i]), timestamps[i], "Timestamp not updated correctly"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 8)
  │   💬 Args: ["=== Gas Scaling Analysis ==="]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 11)
  │   💬 Args: ["Array Size | Gas Used | Gas per Item | Scaling Factor"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 14)
  │   💬 Args: [string(abi.encodePacked(vm.toString(testSizes[i]), " | ", vm.toString(gasUsed[i]), " | ", vm.toString(gasPerItem), " | ", vm.toString(scalingFactor), "%"))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 15)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 16)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 17)
  │   💬 Args: [string(abi.encodePacked("Size ratio: ", vm.toString(sizeRatio), "% | Gas ratio: ", vm.toString(gasRatio), "%"))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 20)
  │   💬 Args: ["\n=== Conclusion ==="]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
      💬 Args: ["Gas scaling appears to be roughly linear with array size"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests gas scaling of batchForwardPPS with different array sizes
