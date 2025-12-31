# Function: help(address,address,uint256,uint256,bytes32,struct VmSafe.Log[])

**Contract**: [lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol/contract_DebridgeDlnHelper.md]

## Metadata

- **Contract**: DebridgeDlnHelper
- **Signature**: `help(address,address,uint256,uint256,bytes32,struct VmSafe.Log[])`
- **Visibility**: external
- **Source Range**: 5649:529:309

## Implementation

```solidity
/// @notice helps process single destination message to relay
///  @param dlnSource represents the source deBridge gate
///  @param dlnDestination represents the destination deBridge gate
///  @param forkId represents the destination chain fork id
///  @param destinationChainId represents the destination chain id
///  @param eventSelector represents a custom event selector
///  @param logs represents the recorded message logs
function help(address dlnSource, address dlnDestination, uint256 forkId, uint256 destinationChainId, bytes32 eventSelector, Vm.Log[] calldata logs) external {
    _help(HelpArgs({dlnSource: dlnSource, dlnDestination: dlnDestination, forkId: forkId, destinationChainId: destinationChainId, eventSelector: eventSelector, logs: logs}));
}
```

## Related Implementations

### _help(struct DebridgeDlnHelper.HelpArgs)

- **Kind**: internal
- **Source**: 6317:3300:309
- **Link**: `lib/v2-core/lib/pigeon/src/debridge/DebridgeDlnHelper.sol:DebridgeDlnHelper:_help(struct DebridgeDlnHelper.HelpArgs)`

```solidity
/// @notice internal function to process a single destination message to relay
///  @param args represents the help arguments
function _help(HelpArgs memory args) internal {
    HelpLocalVars memory vars;
    vars.originChainId = uint256(block.chainid);
    vars.prevForkId = vm.activeFork();
    vars.dlnDestination = args.dlnDestination;
    vars.takerAddress = TAKER_ADDRESS;
    vars.unlockAuthority = vars.takerAddress;
    vars.permitEnvelope = "";
    vars.msgValue = 0;
    uint256 count = args.logs.length;
    for (uint256 i; i < count; ) {
        if ((args.logs[i].emitter == args.dlnSource) && (args.logs[i].topics[0] == args.eventSelector)) {
            (vars.order, vars.orderId, vars.affiliateFee, vars.nativeFixFee, vars.percentFee, vars.reeferralCode, vars.metadata) = abi.decode(args.logs[i].data, (Order, bytes32, bytes, uint256, uint256, uint32, bytes));
            if (vars.order.takeChainId == args.destinationChainId) {
                vm.selectFork(args.forkId);
                DebridgeLogData memory logData = DebridgeLogData({order: vars.order, orderId: vars.orderId, affiliateFee: vars.affiliateFee, nativeFixFee: vars.nativeFixFee, percentFee: vars.percentFee, reeferralCode: vars.reeferralCode, metadata: vars.metadata});
                vars.logData = logData;
                vars.fulfillAmount = vars.order.takeAmount;
                vars.tokenAddress = address(bytes20(vars.order.takeTokenAddress));
                if (vars.tokenAddress == address(0)) {
                    vars.msgValue = vars.fulfillAmount;
                    vm.deal(vars.takerAddress, vars.takerAddress.balance + vars.msgValue);
                } else {
                    deal(vars.tokenAddress, vars.takerAddress, vars.fulfillAmount);
                    vm.prank(vars.takerAddress);
                    IERC20(vars.tokenAddress).approve(vars.dlnDestination, vars.fulfillAmount);
                }
                vm.prank(vars.takerAddress, vars.takerAddress);
                IDlnDestination(vars.dlnDestination).fulfillOrder{value: vars.msgValue}(vars.order, vars.fulfillAmount, vars.orderId, vars.permitEnvelope, vars.unlockAuthority, vars.takerAddress);
                vm.selectFork(vars.prevForkId);
            }
        }
        unchecked {
            ++i;
        }
    }
    if (vm.activeFork() != vars.prevForkId) {
        vm.selectFork(vars.prevForkId);
    }
}
```

## External Calls

- **Vm::activeFork()**
- **Vm::selectFork(uint256)**
- **Vm::deal(address,uint256)**
- **Vm::prank(address)**
- **IERC20::approve(address,uint256)**
- **Vm::prank(address,address)**
- **unknown::unknown**

## State Variable Reads

- **TAKER_ADDRESS** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebridgeDlnHelper.help(address,address,uint256,uint256,bytes32,struct VmSafe.Log[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DebridgeDlnHelper._help(struct DebridgeDlnHelper.HelpArgs) (NodeID: 1)
      💬 Args: [HelpArgs({dlnSource: dlnSource, dlnDestination: dlnDestination, forkId: forkId, destinationChainId: destinationChainId, eventSelector: eventSelector, logs: logs})]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice helps process single destination message to relay
 @param dlnSource represents the source deBridge gate
 @param dlnDestination represents the destination deBridge gate
 @param forkId represents the destination chain fork id
 @param destinationChainId represents the destination chain id
 @param eventSelector represents a custom event selector
 @param logs represents the recorded message logs
