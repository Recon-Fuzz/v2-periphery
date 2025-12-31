# Function: updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)

**Contract**: [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Metadata

- **Contract**: ECDSAPPSOracle
- **Signature**: `updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)`
- **Visibility**: external
- **Source Range**: 3887:1407:532

## Implementation

```solidity
/// @inheritdoc IECDSAPPSOracle
function updatePPS(UpdatePPSArgs calldata args) external {
    uint256 strategiesLength = args.strategies.length;
    if (strategiesLength == 0) revert ZERO_LENGTH_ARRAY();
    if (((strategiesLength != args.proofsArray.length) || (strategiesLength != args.ppss.length)) || (strategiesLength != args.timestamps.length)) revert ARRAY_LENGTH_MISMATCH();
    if (strategiesLength > MAX_STRATEGIES) revert MAX_STRATEGIES_EXCEEDED();
    for (uint256 i = 1; i < strategiesLength; i++) {
        if (args.strategies[i] <= args.strategies[i - 1]) {
            revert STRATEGIES_NOT_SORTED_UNIQUE();
        }
    }
    uint256 cachedTotalValidators = SUPER_GOVERNOR.getValidatorsCount();
    if (cachedTotalValidators == 0) revert INVALID_TOTAL_VALIDATORS();
    ValidatedBatchData memory validatedData = _processBatchStrategies(args, strategiesLength);
    _forwardValidEntries(validatedData);
}
```

## Related Implementations

### _processBatchStrategies(struct IECDSAPPSOracle.UpdatePPSArgs,uint256)

- **Kind**: internal
- **Source**: 9418:1879:532
- **Link**: `src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle:_processBatchStrategies(struct IECDSAPPSOracle.UpdatePPSArgs,uint256)`

```solidity
/// @notice Processes batch strategies and returns valid entries
///  @param args Batch update arguments
///  @param strategiesLength Length of strategies array
///  @return validatedData Struct containing all validated batch data
function _processBatchStrategies(UpdatePPSArgs calldata args, uint256 strategiesLength) internal returns (ValidatedBatchData memory validatedData) {
    uint256 requiredQuorum = SUPER_GOVERNOR.getPPSOracleQuorum();
    uint256 validCount;
    validatedData.strategies = new address[](strategiesLength);
    validatedData.ppss = new uint256[](strategiesLength);
    validatedData.timestamps = new uint256[](strategiesLength);
    validatedData.validatorSets = new uint256[](strategiesLength);
    for (uint256 i; i < strategiesLength; ++i) {
        bool isValid = _processIndividualStrategy(args, i, requiredQuorum);
        if (isValid) {
            validatedData.strategies[validCount] = args.strategies[i];
            validatedData.ppss[validCount] = args.ppss[i];
            validatedData.timestamps[validCount] = args.timestamps[i];
            validatedData.validatorSets[validCount] = args.proofsArray[i].length;
            unchecked {
                ++validCount;
            }
        }
    }
    assembly ("memory-safe") {
        mstore(mload(add(validatedData, 0x00)), validCount)
    }
    assembly ("memory-safe") {
        mstore(mload(add(validatedData, 0x20)), validCount)
    }
    assembly ("memory-safe") {
        mstore(mload(add(validatedData, 0x40)), validCount)
    }
    assembly ("memory-safe") {
        mstore(mload(add(validatedData, 0x60)), validCount)
    }
}
```

### _processIndividualStrategy(struct IECDSAPPSOracle.UpdatePPSArgs,uint256,uint256)

- **Kind**: internal
- **Source**: 11595:1123:532
- **Link**: `src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle:_processIndividualStrategy(struct IECDSAPPSOracle.UpdatePPSArgs,uint256,uint256)`

```solidity
/// @notice Processes an individual strategy in the batch
///  @param args Batch update arguments
///  @param index Index of the strategy to process
///  @param requiredQuorum Required quorum for validation
///  @return isValid True if the strategy was processed successfully
function _processIndividualStrategy(UpdatePPSArgs calldata args, uint256 index, uint256 requiredQuorum) internal returns (bool isValid) {
    address _strategy = args.strategies[index];
    try IECDSAPPSOracle(address(this)).validateProofs(IECDSAPPSOracle.ValidationParams({strategy: _strategy, proofs: args.proofsArray[index], pps: args.ppss[index], timestamp: args.timestamps[index]}), requiredQuorum) {
        emit PPSValidated(_strategy, args.ppss[index], args.timestamps[index], msg.sender);
    } catch Error(string memory reason) {
        emit ProofValidationFailed(_strategy, reason);
        return false;
    } catch (bytes memory lowLevelData) {
        emit ProofValidationFailedLowLevel(_strategy, lowLevelData);
        return false;
    }
    return true;
}
```

### _forwardValidEntries(struct IECDSAPPSOracle.ValidatedBatchData)

- **Kind**: internal
- **Source**: 12855:2441:532
- **Link**: `src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle:_forwardValidEntries(struct IECDSAPPSOracle.ValidatedBatchData)`

```solidity
/// @notice Forwards valid entries to SuperVaultAggregator
///  @param validatedData Struct containing validated batch data
function _forwardValidEntries(ValidatedBatchData memory validatedData) internal {
    uint256 count = validatedData.strategies.length;
    if (count > 0) {
        try ISuperVaultAggregator(SUPER_GOVERNOR.getAddress(SUPER_VAULT_AGGREGATOR)).forwardPPS(ISuperVaultAggregator.ForwardPPSArgs({strategies: validatedData.strategies, ppss: validatedData.ppss, timestamps: validatedData.timestamps, updateAuthority: msg.sender})) {
            for (uint256 i; i < count; ++i) {
                noncePerStrategy[validatedData.strategies[i]]++;
            }
        } catch Error(string memory reason) {
            emit BatchForwardPPSFailed(reason);
        } catch (bytes memory lowLevelData) {
            emit BatchForwardPPSFailedLowLevel(lowLevelData);
        }
    }
}
```

## External Calls

- **ISuperGovernor::getValidatorsCount()**
- **ISuperGovernor::getPPSOracleQuorum()**
- **IECDSAPPSOracle::validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)**
- **ISuperVaultAggregator::forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)**
- **ISuperGovernor::getAddress(bytes32)**

## State Variable Reads

- **MAX_STRATEGIES** (`uint256`)
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)

## State Variable Writes

- **noncePerStrategy** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracle.updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ECDSAPPSOracle._processBatchStrategies(struct IECDSAPPSOracle.UpdatePPSArgs,uint256) (NodeID: 1)
  │   💬 Args: [args, strategiesLength]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ECDSAPPSOracle._processIndividualStrategy(struct IECDSAPPSOracle.UpdatePPSArgs,uint256,uint256) (NodeID: 2)
  │     💬 Args: [args, i, requiredQuorum]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ECDSAPPSOracle._forwardValidEntries(struct IECDSAPPSOracle.ValidatedBatchData) (NodeID: 3)
      💬 Args: [validatedData]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IECDSAPPSOracle

### Interface Documentation

@notice Updates the PPS for multiple strategies in a batch
 @param args Struct containing all parameters for batch PPS update
