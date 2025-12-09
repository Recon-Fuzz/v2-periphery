# Function: test_SetOperator7540Hook_RevokeOperator()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SetOperator7540Hook_RevokeOperator()`
- **Visibility**: public
- **Source Range**: 503951:2193:580

## Implementation

```solidity
/// @notice Test SetOperator7540Hook to revoke an operator
///  @dev This test demonstrates revoking an operator that was previously set
function test_SetOperator7540Hook_RevokeOperator() public {
    address newOperator = makeAddr("operatorToRevoke");
    SetOperator7540Hook setOperatorHook = new SetOperator7540Hook();
    superGovernor.registerHook(address(setOperatorHook));
    bytes memory approveHookData = _encodeSetOperator7540HookData(address(vault), newOperator, true);
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = address(setOperatorHook);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = approveHookData;
    vm.mockCall(address(aggregator), abi.encodeWithSelector(ISuperVaultAggregator.validateHook.selector), abi.encode(true));
    vm.prank(MANAGER);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: new uint256[](1), globalProofs: new bytes32[][](1), strategyProofs: new bytes32[][](1)}));
    assertTrue(vault.isOperator(address(strategy), newOperator), "Operator should be approved");
    bytes memory revokeHookData = _encodeSetOperator7540HookData(address(vault), newOperator, false);
    hooksData[0] = revokeHookData;
    vm.prank(MANAGER);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: new uint256[](1), globalProofs: new bytes32[][](1), strategyProofs: new bytes32[][](1)}));
    assertFalse(vault.isOperator(address(strategy), newOperator), "Operator should be revoked");
    console2.log("SetOperator7540Hook successfully revoked operator on SuperVault");
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

- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::prank(address)**
- **SuperVaultStrategy::executeHooks(struct ISuperVaultStrategy.ExecuteArgs)**
- **SuperVault::isOperator(address,address)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SetOperator7540Hook_RevokeOperator() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["operatorToRevoke"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._encodeSetOperator7540HookData(address,address,bool) (NodeID: 3)
  │   💬 Args: [address(vault), newOperator, true]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 4)
  │   💬 Args: [vault.isOperator(address(strategy), newOperator), "Operator should be approved"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._encodeSetOperator7540HookData(address,address,bool) (NodeID: 5)
  │   💬 Args: [address(vault), newOperator, false]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertFalse(bool,string) (NodeID: 6)
  │   💬 Args: [vault.isOperator(address(strategy), newOperator), "Operator should be revoked"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 7)
      💬 Args: ["SetOperator7540Hook successfully revoked operator on SuperVault"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
        💬 Args: [abi.encodeWithSignature("log(string)", p0)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test SetOperator7540Hook to revoke an operator
 @dev This test demonstrates revoking an operator that was previously set
