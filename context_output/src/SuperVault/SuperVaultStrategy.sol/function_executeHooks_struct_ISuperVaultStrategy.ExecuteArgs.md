# Function: executeHooks(struct ISuperVaultStrategy.ExecuteArgs)

**Contract**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Metadata

- **Contract**: SuperVaultStrategy
- **Signature**: `executeHooks(struct ISuperVaultStrategy.ExecuteArgs)`
- **Visibility**: external
- **Source Range**: 11838:1164:513

## Implementation

```solidity
/// @inheritdoc ISuperVaultStrategy
function executeHooks(ExecuteArgs calldata args) external payable nonReentrant() {
    _isManager(msg.sender);
    uint256 hooksLength = args.hooks.length;
    if (hooksLength == 0) revert ZERO_LENGTH();
    if (args.hookCalldata.length != hooksLength) revert INVALID_ARRAY_LENGTH();
    if (args.expectedAssetsOrSharesOut.length != hooksLength) revert INVALID_ARRAY_LENGTH();
    if (args.globalProofs.length != hooksLength) revert INVALID_ARRAY_LENGTH();
    if (args.strategyProofs.length != hooksLength) revert INVALID_ARRAY_LENGTH();
    address prevHook;
    for (uint256 i; i < hooksLength; ++i) {
        address hook = args.hooks[i];
        if (!_isRegisteredHook(hook)) revert INVALID_HOOK();
        if (!_validateHook(hook, args.hookCalldata[i], args.globalProofs[i], args.strategyProofs[i])) {
            revert HOOK_VALIDATION_FAILED();
        }
        prevHook = _processSingleHookExecution(hook, prevHook, args.hookCalldata[i], args.expectedAssetsOrSharesOut[i]);
    }
    emit HooksExecuted(args.hooks);
}
```

## Related Implementations

### _isManager(address)

- **Kind**: internal
- **Source**: 35413:195:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isManager(address)`

```solidity
/// @notice Internal function to check if a manager is authorized
///  @param manager_ The manager to check
function _isManager(address manager_) internal view {
    if (!_getSuperVaultAggregator().isAnyManager(manager_, address(this))) {
        revert MANAGER_NOT_AUTHORIZED();
    }
}
```

### _getSuperVaultAggregator()

- **Kind**: internal
- **Source**: 35041:251:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_getSuperVaultAggregator()`

```solidity
/// @notice Internal function to get the SuperVaultAggregator
///  @return The SuperVaultAggregator
function _getSuperVaultAggregator() internal view returns (ISuperVaultAggregator) {
    address aggregatorAddress = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_VAULT_AGGREGATOR());
    return ISuperVaultAggregator(aggregatorAddress);
}
```

### _isRegisteredHook(address)

- **Kind**: internal
- **Source**: 40068:130:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_isRegisteredHook(address)`

```solidity
/// @notice Internal function to check if a hook is registered
///  @param hook Address of the hook
///  @return True if the hook is registered, false otherwise
function _isRegisteredHook(address hook) private view returns (bool) {
    return SUPER_GOVERNOR.isHookRegistered(hook);
}
```

### _validateHook(address,bytes,bytes32[],bytes32[])

- **Kind**: internal
- **Source**: 48440:632:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_validateHook(address,bytes,bytes32[],bytes32[])`

```solidity
/// @notice Validates a hook using the Merkle root system
///  @param hook Address of the hook to validate
///  @param hookCalldata Calldata to be passed to the hook
///  @param globalProof Merkle proof for the global root
///  @param strategyProof Merkle proof for the strategy-specific root
///  @return isValid True if the hook is valid, false otherwise
function _validateHook(address hook, bytes memory hookCalldata, bytes32[] memory globalProof, bytes32[] memory strategyProof) internal view returns (bool) {
    return _getSuperVaultAggregator().validateHook(address(this), ISuperVaultAggregator.ValidateHookArgs({hookAddress: hook, hookArgs: ISuperHookInspector(hook).inspect(hookCalldata), globalProof: globalProof, strategyProof: strategyProof}));
}
```

### _processSingleHookExecution(address,address,bytes,uint256)

- **Kind**: internal
- **Source**: 30263:1847:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_processSingleHookExecution(address,address,bytes,uint256)`

```solidity
/// @notice Process a single hook execution
///  @param hook Hook address
///  @param prevHook Previous hook address
///  @param hookCalldata Hook calldata
///  @param expectedAssetsOrSharesOut Expected assets or shares output
///  @return processedHook Processed hook address
function _processSingleHookExecution(address hook, address prevHook, bytes memory hookCalldata, uint256 expectedAssetsOrSharesOut) internal returns (address) {
    ExecutionVars memory vars;
    vars.hookContract = ISuperHook(hook);
    vars.targetedYieldSource = HookDataDecoder.extractYieldSource(hookCalldata);
    bool usePrevHookAmount = _decodeHookUsePrevHookAmount(hook, hookCalldata);
    ISuperHook(address(vars.hookContract)).setExecutionContext(address(this));
    vars.executions = vars.hookContract.build(prevHook, address(this), hookCalldata);
    for (uint256 j; j < vars.executions.length; ++j) {
        address aggregatorAddr = address(_getSuperVaultAggregator());
        if (vars.executions[j].target == aggregatorAddr) revert OPERATION_FAILED();
        (vars.success, ) = vars.executions[j].target.call{value: vars.executions[j].value}(vars.executions[j].callData);
        if (!vars.success) revert OPERATION_FAILED();
    }
    ISuperHook(address(vars.hookContract)).resetExecutionState(address(this));
    uint256 actualOutput = ISuperHookResult(hook).getOutAmount(address(this));
    if (actualOutput < expectedAssetsOrSharesOut) {
        revert MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET();
    }
    emit HookExecuted(hook, prevHook, vars.targetedYieldSource, usePrevHookAmount, hookCalldata);
    return hook;
}
```

### extractYieldSource(bytes)

- **Kind**: internal
- **Source**: 396:131:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSource(bytes)`

```solidity
function extractYieldSource(bytes memory data) internal pure returns (address) {
    return BytesLib.toAddress(data, 32);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

### _decodeHookUsePrevHookAmount(address,bytes)

- **Kind**: internal
- **Source**: 40459:320:513
- **Link**: `src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy:_decodeHookUsePrevHookAmount(address,bytes)`

```solidity
/// @notice Internal function to decode a hook's use previous hook amount
///  @param hook Address of the hook
///  @param hookCalldata Call data for the hook
///  @return True if the hook should use the previous hook amount, false otherwise
function _decodeHookUsePrevHookAmount(address hook, bytes memory hookCalldata) private pure returns (bool) {
    try ISuperHookContextAware(hook).decodeUsePrevHookAmount(hookCalldata) returns (bool usePrevHookAmount) {
        return usePrevHookAmount;
    } catch {
        return false;
    }
}
```

### nonReentrant()

- **Kind**: modifier
- **Source**: 3361:103:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:nonReentrant()`

```solidity
///  @dev Prevents a contract from calling itself, directly or indirectly.
///  Calling a `nonReentrant` function from another `nonReentrant`
///  function is not supported. It is possible to prevent this from happening
///  by making the `nonReentrant` function external, and making it call a
///  `private` function that does the actual work.
modifier nonReentrant() {
    _nonReentrantBefore();
    _;
    _nonReentrantAfter();
}
```

### _nonReentrantBefore()

- **Kind**: internal
- **Source**: 3470:384:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_nonReentrantBefore()`

```solidity
function _nonReentrantBefore() private {
    ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
    if ($._status == ENTERED) {
        revert ReentrancyGuardReentrantCall();
    }
    $._status = ENTERED;
}
```

### _getReentrancyGuardStorage()

- **Kind**: internal
- **Source**: 2395:183:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_getReentrancyGuardStorage()`

```solidity
function _getReentrancyGuardStorage() private pure returns (ReentrancyGuardStorage storage $) {
    assembly {
        $.slot := ReentrancyGuardStorageLocation
    }
}
```

### _nonReentrantAfter()

- **Kind**: internal
- **Source**: 3860:283:36
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ReentrancyGuardUpgradeable.sol:ReentrancyGuardUpgradeable:_nonReentrantAfter()`

```solidity
function _nonReentrantAfter() private {
    ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
    $._status = NOT_ENTERED;
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **ENTERED** (`uint256`)
- **NOT_ENTERED** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultStrategy.executeHooks(struct ISuperVaultStrategy.ExecuteArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isManager(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._isRegisteredHook(address) (NodeID: 3)
  │   💬 Args: [hook]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._validateHook(address,bytes,bytes32[],bytes32[]) (NodeID: 4)
  │   💬 Args: [hook, args.hookCalldata[i], args.globalProofs[i], args.strategyProofs[i]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 5)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultStrategy._processSingleHookExecution(address,address,bytes,uint256) (NodeID: 6)
  │   💬 Args: [hook, prevHook, args.hookCalldata[i], args.expectedAssetsOrSharesOut[i]]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 7)
  │ │   💬 Args: [hookCalldata]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 8)
  │ │     💬 Args: [data, 32]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultStrategy._decodeHookUsePrevHookAmount(address,bytes) (NodeID: 9)
  │ │   💬 Args: [hook, hookCalldata]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SuperVaultStrategy._getSuperVaultAggregator() (NodeID: 10)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: ReentrancyGuardUpgradeable.nonReentrant() (NodeID: 11)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantBefore() (NodeID: 12)
    │   💬 Args: [no args]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 13)
    │     💬 Args: [no args]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._nonReentrantAfter() (NodeID: 14)
        💬 Args: [no args]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: ReentrancyGuardUpgradeable._getReentrancyGuardStorage() (NodeID: 15)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultStrategy

### Interface Documentation

@notice Execute hooks for general strategy management (rebalancing, etc.).
 @param args Execution arguments containing hooks, calldata, proofs, expectations.
