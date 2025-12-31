# Contract: DebridgeHelper

## Metadata

- **Name**: DebridgeHelper
- **Type**: Contract
- **Path**: lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol
- **Documentation**: @title Debridge Helper
   @notice helps simulate Debridge message relaying

## State Variables

### DebridgeSend

```solidity
bytes32 internal constant DebridgeSend = keccak256("Sent(bytes32,bytes32,uint256,bytes,uint256,uint256,uint32,(uint256,uint256,uint256,bool,bool),bytes,address)")
```

## Structs

### HelpArgs

```solidity
struct HelpArgs {
    address srcGate;
    address dstGate;
    uint256 forkId;
    uint256 destinationChainId;
    bytes32 eventSelector;
    Vm.Log[] logs;
}
```

### LocalVars

```solidity
struct LocalVars {
    uint256 prevForkId;
    uint256 originChainId;
    uint256 destinationChainId;
    DebridgeLogData logData;
}
```

### DebridgeLogData

```solidity
struct DebridgeLogData {
    bytes32 submissionId;
    bytes32 debridgeId;
    uint256 amount;
    bytes receiver;
    uint256 nonce;
    uint256 chainIdTo;
    uint32 referralCode;
    IDebridgeGate.FeeParams feeParams;
    bytes autoParams;
    address nativeSender;
}
```

## Public/External Functions

### help(address,address[],uint256[],uint256[],address[],struct VmSafe.Log[])

- **Signature**: `help(address,address[],uint256[],uint256[],address[],struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 1887:797:310
- **Details**: [function_help_address_address[]_uint256[]_uint256[]_address[]_struct_VmSafe_Log[].md](./function_help_address_address[]_uint256[]_uint256[]_address[]_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process multiple destination messages to relay
///  @param srcGate represents the source deBridge gate
///  @param dstGates represents the destination deBridge gates
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param debridgeGateAdmins represents the admin of the debridge gate
///  @param logs represents the recorded message logs
function help(address srcGate, address[] memory dstGates, uint256[] memory forkIds, uint256[] memory destinationChainIds, address[] memory debridgeGateAdmins, Vm.Log[] calldata logs) external;
```

### help(address,address[],uint256[],uint256[],address[],bytes32,struct VmSafe.Log[])

- **Signature**: `help(address,address[],uint256[],uint256[],address[],bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 3217:829:310
- **Details**: [function_help_address_address[]_uint256[]_uint256[]_address[]_bytes32_struct_VmSafe_Log[].md](./function_help_address_address[]_uint256[]_uint256[]_address[]_bytes32_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process multiple destination messages to relay
///  @param srcGate represents the source deBridge gate
///  @param dstGates represents the destination deBridge gate
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param debridgeGateAdmins represents the admin of the debridge gate
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address srcGate, address[] memory dstGates, uint256[] memory forkIds, uint256[] memory destinationChainIds, address[] memory debridgeGateAdmins, bytes32 eventSelector, Vm.Log[] calldata logs) external;
```

### help(address,address,address,uint256,uint256,struct VmSafe.Log[])

- **Signature**: `help(address,address,address,uint256,uint256,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 4506:536:310
- **Details**: [function_help_address_address_address_uint256_uint256_struct_VmSafe_Log[].md](./function_help_address_address_address_uint256_uint256_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process single destination message to relay
///  @param debridgeGateAdmin represents the admin of the debridge gate
///  @param srcGate represents the source deBridge gate
///  @param dstGate represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param logs represents the recorded message logs
function help(address debridgeGateAdmin, address srcGate, address dstGate, uint256 forkId, uint256 destinationChainId, Vm.Log[] calldata logs) external;
```

### help(address,address,address,uint256,uint256,bytes32,struct VmSafe.Log[])

- **Signature**: `help(address,address,address,uint256,uint256,bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 5566:568:310
- **Details**: [function_help_address_address_address_uint256_uint256_bytes32_struct_VmSafe_Log[].md](./function_help_address_address_address_uint256_uint256_bytes32_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process single destination message to relay
///  @param debridgeGateAdmin represents the admin of the debridge gate
///  @param srcGate represents the source deBridge gate
///  @param dstGate represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address debridgeGateAdmin, address srcGate, address dstGate, uint256 forkId, uint256 destinationChainId, bytes32 eventSelector, Vm.Log[] calldata logs) external;
```
