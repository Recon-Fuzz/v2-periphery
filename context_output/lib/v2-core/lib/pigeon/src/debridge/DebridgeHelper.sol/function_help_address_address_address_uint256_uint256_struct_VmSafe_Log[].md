# Function: help(address,address,address,uint256,uint256,struct VmSafe.Log[])

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol/contract_DebridgeHelper.md]

## Metadata

- **Contract**: DebridgeHelper
- **Signature**: `help(address,address,address,uint256,uint256,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 4506:536:310

## Implementation

```solidity
/// @notice helps process single destination message to relay
///  @param debridgeGateAdmin represents the admin of the debridge gate
///  @param srcGate represents the source deBridge gate
///  @param dstGate represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param logs represents the recorded message logs
function help(address debridgeGateAdmin, address srcGate, address dstGate, uint256 forkId, uint256 destinationChainId, Vm.Log[] calldata logs) external {
    _help(HelpArgs({srcGate: srcGate, dstGate: dstGate, forkId: forkId, destinationChainId: destinationChainId, eventSelector: DebridgeSend, logs: logs}), debridgeGateAdmin);
}
```

## Related Implementations

### _help(struct DebridgeHelper.HelpArgs,address)

- **Kind**: internal
- **Source**: 6273:2418:310
- **Link**: `lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol:DebridgeHelper:_help(struct DebridgeHelper.HelpArgs,address)`

```solidity
/// @notice internal function to process a single destination message to relay
///  @param args represents the help arguments
function _help(HelpArgs memory args, address debridgeGateAdmin) internal {
    LocalVars memory vars;
    vars.originChainId = uint256(block.chainid);
    vars.prevForkId = vm.activeFork();
    uint256 count = args.logs.length;
    for (uint256 i; i < count; ) {
        if ((args.logs[i].topics[0] == args.eventSelector) && (args.logs[i].emitter == args.srcGate)) {
            vm.selectFork(args.forkId);
            vars.destinationChainId = uint256(args.logs[i].topics[2]);
            if (vars.destinationChainId == args.destinationChainId) {
                DebridgeLogData memory logData = _decodeLogData(args.logs[i], args.logs[i].topics[1], vars.destinationChainId);
                vars.logData = logData;
                DeBridgeSignatureVerifierMock _verifier = new DeBridgeSignatureVerifierMock();
                vm.startPrank(debridgeGateAdmin);
                IDebridgeGate(args.dstGate).setSignatureVerifier(address(_verifier));
                vm.stopPrank();
                IDebridgeGate.DebridgeInfo memory debridgeInfo = IDebridgeGate(args.dstGate).getDebridge(logData.debridgeId);
                deal(debridgeInfo.tokenAddress, args.dstGate, logData.amount);
                address receiver = address(bytes20(logData.receiver));
                IDebridgeGate(args.dstGate).claim(logData.debridgeId, logData.amount, vars.originChainId, receiver, logData.nonce, "", logData.autoParams);
            }
        }
        unchecked {
            ++i;
        }
    }
    vm.selectFork(vars.prevForkId);
}
```

### _decodeLogData(struct VmSafe.Log,bytes32,uint256)

- **Kind**: internal
- **Source**: 8697:970:310
- **Link**: `lib/v2-core/lib/pigeon/src/debridge/DebridgeHelper.sol:DebridgeHelper:_decodeLogData(struct VmSafe.Log,bytes32,uint256)`

```solidity
function _decodeLogData(Vm.Log memory log, bytes32 debridgeId, uint256 chainIdTo) internal pure returns (DebridgeLogData memory data) {
    (bytes32 submissionId, uint256 amount, bytes memory receiver, uint256 nonce, uint32 referralCode, IDebridgeGate.FeeParams memory feeParams, bytes memory autoParams, address nativeSender) = abi.decode(log.data, (bytes32, uint256, bytes, uint256, uint32, IDebridgeGate.FeeParams, bytes, address));
    return DebridgeLogData({submissionId: submissionId, debridgeId: debridgeId, amount: amount, receiver: receiver, nonce: nonce, chainIdTo: chainIdTo, referralCode: referralCode, feeParams: feeParams, autoParams: autoParams, nativeSender: nativeSender});
}
```

## External Calls

- **Vm::activeFork()**
- **Vm::selectFork(uint256)**
- **Vm::startPrank(address)**
- **IDebridgeGate::setSignatureVerifier(address)**
- **Vm::stopPrank()**
- **IDebridgeGate::getDebridge(bytes32)**
- **IDebridgeGate::claim(bytes32,uint256,uint256,address,uint256,bytes,bytes)**

## State Variable Reads

- **DebridgeSend** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebridgeHelper.help(address,address,address,uint256,uint256,struct VmSafe.Log[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DebridgeHelper._help(struct DebridgeHelper.HelpArgs,address) (NodeID: 1)
      💬 Args: [HelpArgs({srcGate: srcGate, dstGate: dstGate, forkId: forkId, destinationChainId: destinationChainId, eventSelector: DebridgeSend, logs: logs}), debridgeGateAdmin]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DebridgeHelper._decodeLogData(struct VmSafe.Log,bytes32,uint256) (NodeID: 2)
        💬 Args: [args.logs[i], args.logs[i].topics[1], vars.destinationChainId]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice helps process single destination message to relay
 @param debridgeGateAdmin represents the admin of the debridge gate
 @param srcGate represents the source deBridge gate
 @param dstGate represents the destination deBridge gate
 @param forkId represents the destination chain fork id
 @param destinationChainId represents the destination chain id
 @param logs represents the recorded message logs
