# Contract: AcrossV3Helper

## Metadata

- **Name**: AcrossV3Helper
- **Type**: Contract
- **Path**: lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol
- **Documentation**: @title AcrossV3 Helper
   @notice helps simulate AcrossV3 message relaying

## State Variables

### V3FundsDeposited

```solidity
bytes32 internal constant V3FundsDeposited = keccak256("V3FundsDeposited(address,address,uint256,uint256,uint256,uint32,uint32,uint32,uint32,address,address,address,bytes)")
```

### FundsDeposited

```solidity
bytes32 internal constant FundsDeposited = keccak256("FundsDeposited(bytes32,bytes32,uint256,uint256,uint256,uint256,uint32,uint32,uint32,bytes32,bytes32,bytes32,bytes)")
```

## Structs

### HelpArgs

```solidity
struct HelpArgs {
    address sourceSpokePool;
    address destinationSpokePool;
    address relayer;
    uint256 forkId;
    uint256 destinationChainId;
    uint256 refundChainId;
    uint256 warpTimestamp;
    Vm.Log[] logs;
}
```

### AcrossV3LogData

```solidity
struct AcrossV3LogData {
    address inputToken;
    address outputToken;
    uint256 inputAmount;
    uint256 outputAmount;
    uint32 quoteTimestamp;
    uint32 fillDeadline;
    uint32 exclusivityDeadline;
    address recipient;
    address exclusiveRelayer;
    bytes message;
}
```

### LocalVars

```solidity
struct LocalVars {
    uint256 prevForkId;
    uint256 originChainId;
    uint256 destinationChainId;
    AcrossV3LogData logData;
}
```

## Public/External Functions

### help(address,address[],address,uint256,uint256[],uint256[],uint256[],struct VmSafe.Log[])

- **Signature**: `help(address,address[],address,uint256,uint256[],uint256[],uint256[],struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 1532:880:306
- **Details**: [function_help_address_address[]_address_uint256_uint256[]_uint256[]_uint256[]_struct_VmSafe_Log[].md](./function_help_address_address[]_address_uint256_uint256[]_uint256[]_uint256[]_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process multiple destination messages to relay
///  @param sourceSpokePool represents the across spoke pool on the source chain
///  @param destinationSpokePools represents the across spoke pools on the destination chain
///  @param relayer represents the relayer address
///  @param warpTimestamp represents the warp timestamp
///  @param forkIds represents the destination chain fork ids
///  @param destinationChainIds represents the destination chain ids
///  @param refundChainIds represents the refund chain ids
///  @param logs represents the recorded message logs
function help(address sourceSpokePool, address[] memory destinationSpokePools, address relayer, uint256 warpTimestamp, uint256[] memory forkIds, uint256[] memory destinationChainIds, uint256[] memory refundChainIds, Vm.Log[] calldata logs) external;
```

### help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[])

- **Signature**: `help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 2957:701:306
- **Details**: [function_help_address_address_address_uint256_uint256_uint256_uint256_struct_VmSafe_Log[].md](./function_help_address_address_address_uint256_uint256_uint256_uint256_struct_VmSafe_Log[].md)

**Signature:**
```solidity
/// @notice helps process a single destination message to relay
///  @param sourceSpokePool represents the across spoke pool on the source chain
///  @param destinationSpokePool represents the across spoke pool on the destination chain
///  @param relayer represents the relayer address
///  @param warpTimestamp represents the warp timestamp
///  @param forkId represents the destination chain fork id
///  @param refundChainId represents the refund chain id
///  @param logs represents the recorded message logs
function help(address sourceSpokePool, address destinationSpokePool, address relayer, uint256 warpTimestamp, uint256 forkId, uint256 destinationChainId, uint256 refundChainId, Vm.Log[] calldata logs) external;
```

### help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[],uint256)

- **Signature**: `help(address,address,address,uint256,uint256,uint256,uint256,struct VmSafe.Log[],uint256)`
- **Visibility**: external
- **Source Range**: 4195:749:306
- **Details**: [function_help_address_address_address_uint256_uint256_uint256_uint256_struct_VmSafe_Log[]_uint256.md](./function_help_address_address_address_uint256_uint256_uint256_uint256_struct_VmSafe_Log[]_uint256.md)

**Signature:**
```solidity
/// @notice helps process a single destination message to relay
///  @param sourceSpokePool represents the across spoke pool on the source chain
///  @param destinationSpokePool represents the across spoke pool on the destination chain
///  @param relayer represents the relayer address
///  @param warpTimestamp represents the warp timestamp
///  @param forkId represents the destination chain fork id
///  @param refundChainId represents the refund chain id
///  @param gasLimit represents the gas limit
function help(address sourceSpokePool, address destinationSpokePool, address relayer, uint256 warpTimestamp, uint256 forkId, uint256 destinationChainId, uint256 refundChainId, Vm.Log[] calldata logs, uint256 gasLimit) external;
```
