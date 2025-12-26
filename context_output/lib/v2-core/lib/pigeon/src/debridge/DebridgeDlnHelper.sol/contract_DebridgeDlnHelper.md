# Contract: DebridgeDlnHelper

## Metadata

- **Name**: DebridgeDlnHelper
- **Type**: Contract
- **Path**: lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol
- **Documentation**: @title Debridge DLN Helper
   @notice helps simulate Debridge DLN message relaying with hooks

## State Variables

### DlnOrderCreated

```solidity
bytes32 internal constant DlnOrderCreated = keccak256("CreatedOrder((uint64,bytes,uint256,bytes,uint256,uint256,bytes,uint256,bytes,bytes,bytes,bytes,bytes,bytes),bytes32,bytes,uint256,uint256,uint32,bytes)")
```

### TAKER_ADDRESS

```solidity
address internal constant TAKER_ADDRESS = 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf
```

## Structs

### HelpArgs

```solidity
struct HelpArgs {
    address dlnSource;
    address dlnDestination;
    uint256 forkId;
    uint256 destinationChainId;
    bytes32 eventSelector;
    Vm.Log[] logs;
}
```

### DebridgeLogData

```solidity
struct DebridgeLogData {
    Order order;
    bytes32 orderId;
    bytes affiliateFee;
    uint256 nativeFixFee;
    uint256 percentFee;
    uint32 reeferralCode;
    bytes metadata;
}
```

### HelpLocalVars

```solidity
struct HelpLocalVars {
    uint256 prevForkId;
    uint256 originChainId;
    address dlnDestination;
    address takerAddress;
    address unlockAuthority;
    uint256 fulfillAmount;
    address tokenAddress;
    bytes permitEnvelope;
    uint256 msgValue;
    DebridgeLogData logData;
    Order order;
    bytes32 orderId;
    bytes affiliateFee;
    uint256 nativeFixFee;
    uint256 percentFee;
    uint32 reeferralCode;
    bytes metadata;
}
```

## Public/External Functions

### help(address,address[],uint256[],uint256[],struct VmSafe.Log[])

- **Signature**: `help(address,address[],uint256[],uint256[],struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 2316:743:309
- **Details**: [function_help_address_address[]_uint256[]_uint256[]_struct_VmSafe_Log[].md](./function_help_address_address[]_uint256[]_uint256[]_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process multiple destination messages to relay
///  @param dlnSource represents the source deBridge DLN
///  @param dlnDestinations represents the destination deBridge DLNs
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param logs represents the recorded message logs
function help(address dlnSource, address[] memory dlnDestinations, uint256[] memory forkIds, uint256[] memory destinationChainIds, Vm.Log[] calldata logs) external;
```

### help(address,address[],uint256[],uint256[],bytes32,struct VmSafe.Log[])

- **Signature**: `help(address,address[],uint256[],uint256[],bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 3525:772:309
- **Details**: [function_help_address_address[]_uint256[]_uint256[]_bytes32_struct_VmSafe_Log[].md](./function_help_address_address[]_uint256[]_uint256[]_bytes32_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process multiple destination messages to relay
///  @param dlnSource represents the source deBridge gate
///  @param dlnDestinations represents the destination deBridge gate
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address dlnSource, address[] memory dlnDestinations, uint256[] memory forkIds, uint256[] memory destinationChainIds, bytes32 eventSelector, Vm.Log[] calldata logs) external;
```

### help(address,address,uint256,uint256,struct VmSafe.Log[])

- **Signature**: `help(address,address,uint256,uint256,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 4691:500:309
- **Details**: [function_help_address_address_uint256_uint256_struct_VmSafe_Log[].md](./function_help_address_address_uint256_uint256_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process single destination message to relay
///  @param dlnSource represents the source deBridge gate
///  @param dlnDestination represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param logs represents the recorded message logs
function help(address dlnSource, address dlnDestination, uint256 forkId, uint256 destinationChainId, Vm.Log[] calldata logs) external;
```

### help(address,address,uint256,uint256,bytes32,struct VmSafe.Log[])

- **Signature**: `help(address,address,uint256,uint256,bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 5649:529:309
- **Details**: [function_help_address_address_uint256_uint256_bytes32_struct_VmSafe_Log[].md](./function_help_address_address_uint256_uint256_bytes32_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process single destination message to relay
///  @param dlnSource represents the source deBridge gate
///  @param dlnDestination represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address dlnSource, address dlnDestination, uint256 forkId, uint256 destinationChainId, bytes32 eventSelector, Vm.Log[] calldata logs) external;
```
