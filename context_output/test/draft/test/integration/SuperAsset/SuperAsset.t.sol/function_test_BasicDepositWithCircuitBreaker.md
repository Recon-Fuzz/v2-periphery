# Function: test_BasicDepositWithCircuitBreaker()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `test_BasicDepositWithCircuitBreaker()`
- **Visibility**: public
- **Source Range**: 24322:871:565

## Implementation

```solidity
function test_BasicDepositWithCircuitBreaker() public {
    console.log("test_BasicDepositWithCircuitBreaker() Start");
    BasicDepositWithCircuitBreaker memory s;
    s.depositAmount = 100e18;
    s.minSharesOut = 99e18;
    vm.startPrank(user);
    tokenIn.approve(address(superAsset), s.depositAmount);
    (, s.currentPrice, , , ) = mockFeed2.latestRoundData();
    mockFeed2.setAnswer(s.currentPrice * 3);
    (, s.currentPrice, , , ) = mockFeed3.latestRoundData();
    mockFeed3.setAnswer(s.currentPrice * 5);
    (s.priceUSD, s.isDepeg, s.isDispersion, s.isOracleOff) = superAsset.getPriceAndCircuitBreakers(IERC4626(tokenIn).asset());
    assertEq(s.isDepeg, true);
    assertEq(s.isDispersion, true);
    assertEq(s.isOracleOff, false);
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

### assertEq(bool,bool)

- **Kind**: internal
- **Source**: 2334:147:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool)`

```solidity
function assertEq(bool left, bool right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **Mock4626Vault::approve(address,uint256)**
- **MockAggregator::latestRoundData()**
- **MockAggregator::setAnswer(int256)**
- **SuperAsset::getPriceAndCircuitBreakers(address)**
- **IERC4626::asset()**

## State Variable Reads

- **user** (`address`)
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.test_BasicDepositWithCircuitBreaker() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1)
  │   💬 Args: ["test_BasicDepositWithCircuitBreaker() Start"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool) (NodeID: 4)
  │   💬 Args: [s.isDepeg, true]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool) (NodeID: 5)
  │   💬 Args: [s.isDispersion, true]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool) (NodeID: 6)
      💬 Args: [s.isOracleOff, false]
      👁️  Def: internal
```
