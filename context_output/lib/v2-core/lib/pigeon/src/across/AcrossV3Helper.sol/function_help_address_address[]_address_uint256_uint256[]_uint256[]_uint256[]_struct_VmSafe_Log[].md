# Function: help(address,address[],address,uint256,uint256[],uint256[],uint256[],struct VmSafe.Log[])

**Contract**: [lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol/contract_AcrossV3Helper.md]

## Metadata

- **Contract**: AcrossV3Helper
- **Signature**: `help(address,address[],address,uint256,uint256[],uint256[],uint256[],struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 1532:880:306

## Implementation

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
function help(address sourceSpokePool, address[] memory destinationSpokePools, address relayer, uint256 warpTimestamp, uint256[] memory forkIds, uint256[] memory destinationChainIds, uint256[] memory refundChainIds, Vm.Log[] calldata logs) external {
    for (uint256 i; i < destinationSpokePools.length; ++i) {
        _help(HelpArgs({sourceSpokePool: sourceSpokePool, destinationSpokePool: destinationSpokePools[i], relayer: relayer, forkId: forkIds[i], destinationChainId: destinationChainIds[i], refundChainId: refundChainIds[i], warpTimestamp: warpTimestamp, logs: logs}));
    }
}
```

## Related Implementations

### _help(struct AcrossV3Helper.HelpArgs)

- **Kind**: internal
- **Source**: 5843:2711:306
- **Link**: `lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol:AcrossV3Helper:_help(struct AcrossV3Helper.HelpArgs)`

```solidity
/// @notice internal function to process a single destination message to relay
///  @param args represents the help arguments
function _help(HelpArgs memory args) internal {
    LocalVars memory vars;
    vars.originChainId = uint256(block.chainid);
    vars.prevForkId = vm.activeFork();
    vm.selectFork(args.forkId);
    if (args.warpTimestamp > 0) {
        vm.warp(args.warpTimestamp);
    }
    vm.startBroadcast(args.relayer);
    for (uint256 i; i < args.logs.length; i++) {
        if (((args.logs[i].topics[0] == FundsDeposited) || (args.logs[i].topics[0] == V3FundsDeposited)) && (args.logs[i].emitter == args.sourceSpokePool)) {
            vars.destinationChainId = uint256(args.logs[i].topics[1]);
            if (vars.destinationChainId == args.destinationChainId) {
                vars.logData = _decodeLogData(args.logs[i]);
                assertEq(vars.destinationChainId, args.destinationChainId);
                deal(vars.logData.outputToken, args.relayer, vars.logData.outputAmount);
                IERC20(vars.logData.outputToken).approve(args.destinationSpokePool, vars.logData.outputAmount);
                IAcrossSpokePoolV3(args.destinationSpokePool).fillV3Relay(IAcrossSpokePoolV3.V3RelayData({depositor: address(uint160(uint256(args.logs[i].topics[2]))), recipient: vars.logData.recipient, exclusiveRelayer: vars.logData.exclusiveRelayer, inputToken: vars.logData.inputToken, outputToken: vars.logData.outputToken, inputAmount: vars.logData.inputAmount, outputAmount: vars.logData.outputAmount, originChainId: vars.originChainId, depositId: uint32(uint256(args.logs[i].topics[1])), fillDeadline: vars.logData.fillDeadline, exclusivityDeadline: vars.logData.exclusivityDeadline, message: vars.logData.message}), args.refundChainId);
            }
        }
    }
    vm.stopBroadcast();
    vm.selectFork(vars.prevForkId);
}
```

### _decodeLogData(struct VmSafe.Log)

- **Kind**: internal
- **Source**: 11492:1021:306
- **Link**: `lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol:AcrossV3Helper:_decodeLogData(struct VmSafe.Log)`

```solidity
function _decodeLogData(Vm.Log memory log) internal pure returns (AcrossV3LogData memory data) {
    (address inputToken, address outputToken, uint256 inputAmount, uint256 outputAmount, uint32 quoteTimestamp, uint32 fillDeadline, uint32 exclusivityDeadline, address recipient, address exclusiveRelayer, bytes memory message) = abi.decode(log.data, (address, address, uint256, uint256, uint32, uint32, uint32, address, address, bytes));
    return AcrossV3LogData({inputToken: inputToken, outputToken: outputToken, inputAmount: inputAmount, outputAmount: outputAmount, quoteTimestamp: quoteTimestamp, fillDeadline: fillDeadline, exclusivityDeadline: exclusivityDeadline, recipient: recipient, exclusiveRelayer: exclusiveRelayer, message: message});
}
```

## External Calls

- **Vm::activeFork()**
- **Vm::selectFork(uint256)**
- **Vm::warp(uint256)**
- **Vm::startBroadcast(address)**
- **IERC20::approve(address,uint256)**
- **IAcrossSpokePoolV3::fillV3Relay(struct IAcrossSpokePoolV3.V3RelayData,uint256)**
- **Vm::stopBroadcast()**

## State Variable Reads

- **FundsDeposited** (`bytes32`)
- **V3FundsDeposited** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AcrossV3Helper.help(address,address[],address,uint256,uint256[],uint256[],uint256[],struct VmSafe.Log[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AcrossV3Helper._help(struct AcrossV3Helper.HelpArgs) (NodeID: 1)
      💬 Args: [HelpArgs({sourceSpokePool: sourceSpokePool, destinationSpokePool: destinationSpokePools[i], relayer: relayer, forkId: forkIds[i], destinationChainId: destinationChainIds[i], refundChainId: refundChainIds[i], warpTimestamp: warpTimestamp, logs: logs})]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AcrossV3Helper._decodeLogData(struct VmSafe.Log) (NodeID: 2)
        💬 Args: [args.logs[i]]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice helps process multiple destination messages to relay
 @param sourceSpokePool represents the across spoke pool on the source chain
 @param destinationSpokePools represents the across spoke pools on the destination chain
 @param relayer represents the relayer address
 @param warpTimestamp represents the warp timestamp
 @param forkIds represents the destination chain fork ids
 @param destinationChainIds represents the destination chain ids
 @param refundChainIds represents the refund chain ids
 @param logs represents the recorded message logs
