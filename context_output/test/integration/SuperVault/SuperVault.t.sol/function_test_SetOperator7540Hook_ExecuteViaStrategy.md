# Function: test_SetOperator7540Hook_ExecuteViaStrategy()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetOperator7540Hook_ExecuteViaStrategy()`
- **Visibility**: public
- **Source Range**: 501621:2180:580

## Implementation

```solidity
/// @notice Test SetOperator7540Hook execution via strategy.executeHooks
///  @dev This test demonstrates setting an operator on the SuperVault via the SetOperator7540Hook
function test_SetOperator7540Hook_ExecuteViaStrategy() public {
    address newOperator = makeAddr("newOperator");
    SetOperator7540Hook setOperatorHook = new SetOperator7540Hook();
    vm.label(address(setOperatorHook), "SetOperator7540Hook");
    superGovernor.registerHook(address(setOperatorHook));
    assertFalse(vault.isOperator(address(strategy), newOperator), "Operator should not be set initially");
    bytes memory hookData = _encodeSetOperator7540HookData(address(vault), newOperator, true);
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = address(setOperatorHook);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = hookData;
    vm.mockCall(address(aggregator), abi.encodeWithSelector(ISuperVaultAggregator.validateHook.selector), abi.encode(true));
    vm.startPrank(MANAGER);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: new uint256[](1), globalProofs: new bytes32[][](1), strategyProofs: new bytes32[][](1)}));
    vm.stopPrank();
    assertTrue(vault.isOperator(address(strategy), newOperator), "Operator should be set after hook execution");
    console2.log("SetOperator7540Hook successfully set operator on SuperVault");
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
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

### _encodeSetOperator7540HookData(address,address,bool)

- **Kind**: internal
- **Source**: 508562:614:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_encodeSetOperator7540HookData(address,address,bool)`

```solidity
/// @notice Helper function to encode data for SetOperator7540Hook
///  @param vault_ The vault address (ERC-7540 vault)
///  @param operator_ The operator address to set
///  @param approved_ Whether to approve or revoke the operator
///  @return hookData The encoded hook data
function _encodeSetOperator7540HookData(address vault_, address operator_, bool approved_) internal pure returns (bytes memory hookData) {
    bytes memory placeholder = new bytes(32);
    hookData = bytes.concat(placeholder, abi.encodePacked(vault_), abi.encodePacked(operator_), abi.encodePacked(approved_ ? uint8(1) : uint8(0)));
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

- **Vm::label(address,string)**
- **SuperGovernor::registerHook(address)**
- **SuperVault::isOperator(address,address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::startPrank(address)**
- **SuperVaultStrategy::executeHooks(struct ISuperVaultStrategy.ExecuteArgs)**
- **Vm::stopPrank()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetOperator7540Hook_ExecuteViaStrategy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["newOperator"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 3)
  │   💬 Args: [vault.isOperator(address(strategy), newOperator), "Operator should not be set initially"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._encodeSetOperator7540HookData(address,address,bool) (NodeID: 4)
  │   💬 Args: [address(vault), newOperator, true]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 5)
  │   💬 Args: [vault.isOperator(address(strategy), newOperator), "Operator should be set after hook execution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 6)
      💬 Args: ["SetOperator7540Hook successfully set operator on SuperVault"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 7)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 8)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test SetOperator7540Hook execution via strategy.executeHooks
 @dev This test demonstrates setting an operator on the SuperVault via the SetOperator7540Hook
