# Function: test_executeHooks_InvalidMerkleProof()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_executeHooks_InvalidMerkleProof()`
- **Visibility**: public
- **Source Range**: 45622:1653:570

## Implementation

```solidity
function test_executeHooks_InvalidMerkleProof() public {
    console.log("VaultBank address:", address(vaultBank));
    console.log("Test contract address (this):", address(this));
    console.log("This has BANK_MANAGER_ROLE:", superGovernor.hasRole(superGovernor.BANK_MANAGER_ROLE(), address(this)));
    vm.startPrank(address(this));
    MockHookTarget mockTarget = new MockHookTarget();
    MockSuperHook mockHook2 = new MockSuperHook(address(mockTarget));
    vm.stopPrank();
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook2));
    vm.startPrank(address(this));
    address[] memory hooks = new address[](1);
    hooks[0] = address(mockHook2);
    bytes[] memory data = new bytes[](1);
    data[0] = "data1";
    bytes32[][] memory merkleProofs = new bytes32[][](1);
    merkleProofs[0] = new bytes32[](1);
    merkleProofs[0][0] = bytes32(uint256(1));
    uint256[] memory expectedOutputs = new uint256[](hooks.length);
    IHookExecutionData.HookExecutionData memory executionData = IHookExecutionData.HookExecutionData({hooks: hooks, data: data, merkleProofs: merkleProofs, expectedAssetsOrSharesOut: expectedOutputs});
    vm.mockCall(address(superRegistry), abi.encodeWithSignature("getVaultBankHookMerkleRoot(address)", address(mockHook2)), abi.encode(bytes32(uint256(2))));
    vm.expectRevert(Bank.HOOK_VALIDATION_FAILED.selector);
    vaultBank.executeHooks(executionData);
    vm.stopPrank();
}
```

## Related Implementations

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

### log(string,bool)

- **Kind**: internal
- **Source**: 7595:139:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,bool)`

```solidity
function log(string memory p0, bool p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
}
```

## External Calls

- **SuperGovernor::hasRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **TestVaultBank::executeHooks(struct IHookExecutionData.HookExecutionData)**

## State Variable Reads

- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **governor** (`address`)
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_executeHooks_InvalidMerkleProof() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1)
  │   💬 Args: ["VaultBank address:", address(vaultBank)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 4)
  │   💬 Args: ["Test contract address (this):", address(this)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string,bool) (NodeID: 7)
      💬 Args: ["This has BANK_MANAGER_ROLE:", superGovernor.hasRole(superGovernor.BANK_MANAGER_ROLE(), address(this))]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
        💬 Args: [abi.encodeWithSignature("log(string,bool)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
