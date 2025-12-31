# Function: setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])

**Contract**: [lib/v2-core/src/accounting/SuperLedgerConfiguration.sol/contract_SuperLedgerConfiguration.md]

## Metadata

- **Contract**: SuperLedgerConfiguration
- **Signature**: `setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])`
- **Visibility**: external
- **Source Range**: 3336:615:353

## Implementation

```solidity
/// @inheritdoc ISuperLedgerConfiguration
function setYieldSourceOracles(bytes32[] calldata salts, YieldSourceOracleConfigArgs[] calldata configs) virtual external {
    uint256 length = configs.length;
    if (length == 0) revert ZERO_LENGTH();
    if (length != salts.length) revert LENGTH_MISMATCH();
    for (uint256 i; i < length; ++i) {
        YieldSourceOracleConfigArgs calldata config = configs[i];
        _setInitialYieldSourceOracleConfig(salts[i], config.yieldSourceOracle, config.feePercent, config.feeRecipient, config.ledger);
    }
}
```

## Related Implementations

### _setInitialYieldSourceOracleConfig(bytes32,address,uint256,address,address)

- **Kind**: internal
- **Source**: 12700:1207:353
- **Link**: `lib/v2-core/src/accounting/SuperLedgerConfiguration.sol:SuperLedgerConfiguration:_setInitialYieldSourceOracleConfig(bytes32,address,uint256,address,address)`

```solidity
function _setInitialYieldSourceOracleConfig(bytes32 salt, address yieldSourceOracle, uint256 feePercent, address feeRecipient, address ledgerContract) virtual internal {
    _validateYieldSourceOracleConfig(salt, yieldSourceOracle, feePercent, feeRecipient, ledgerContract);
    bytes32 yieldSourceOracleId = _deriveWithSender(salt, msg.sender);
    yieldSourceOracleIdsByOwner[msg.sender].push(yieldSourceOracleId);
    YieldSourceOracleConfig memory existingConfig = yieldSourceOracleConfig[yieldSourceOracleId];
    if ((existingConfig.manager != address(0)) && (existingConfig.ledger != address(0))) revert CONFIG_EXISTS();
    yieldSourceOracleConfig[yieldSourceOracleId] = YieldSourceOracleConfig({yieldSourceOracle: yieldSourceOracle, feePercent: feePercent, feeRecipient: feeRecipient, manager: msg.sender, ledger: ledgerContract});
    emit YieldSourceOracleConfigSet(yieldSourceOracleId, yieldSourceOracle, feePercent, feeRecipient, msg.sender, ledgerContract);
}
```

### _validateYieldSourceOracleConfig(bytes32,address,uint256,address,address)

- **Kind**: internal
- **Source**: 13913:618:353
- **Link**: `lib/v2-core/src/accounting/SuperLedgerConfiguration.sol:SuperLedgerConfiguration:_validateYieldSourceOracleConfig(bytes32,address,uint256,address,address)`

```solidity
function _validateYieldSourceOracleConfig(bytes32 salt, address yieldSourceOracle, uint256 feePercent, address feeRecipient, address ledgerContract) virtual internal view {
    if (yieldSourceOracle == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (feeRecipient == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (ledgerContract == address(0)) revert ZERO_ADDRESS_NOT_ALLOWED();
    if (feePercent > MAX_FEE_PERCENT) revert INVALID_FEE_PERCENT();
    if (salt == bytes32(0)) revert ZERO_ID_NOT_ALLOWED();
}
```

### _deriveWithSender(bytes32,address)

- **Kind**: internal
- **Source**: 14537:150:353
- **Link**: `lib/v2-core/src/accounting/SuperLedgerConfiguration.sol:SuperLedgerConfiguration:_deriveWithSender(bytes32,address)`

```solidity
function _deriveWithSender(bytes32 id, address sender) internal pure returns (bytes32) {
    return keccak256(abi.encodePacked(id, sender));
}
```

## State Variable Reads

- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)
- **MAX_FEE_PERCENT** (`uint256`)

## State Variable Writes

- **yieldSourceOracleIdsByOwner** (`mapping(address => bytes32[])`)
- **yieldSourceOracleConfig** (`mapping(bytes32 => struct ISuperLedgerConfiguration.YieldSourceOracleConfig)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperLedgerConfiguration.setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperLedgerConfiguration._setInitialYieldSourceOracleConfig(bytes32,address,uint256,address,address) (NodeID: 1)
      💬 Args: [salts[i], config.yieldSourceOracle, config.feePercent, config.feeRecipient, config.ledger]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperLedgerConfiguration._validateYieldSourceOracleConfig(bytes32,address,uint256,address,address) (NodeID: 2)
    │   💬 Args: [salt, yieldSourceOracle, feePercent, feeRecipient, ledgerContract]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperLedgerConfiguration._deriveWithSender(bytes32,address) (NodeID: 3)
        💬 Args: [salt, msg.sender]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedgerConfiguration

### Interface Documentation

@notice Creates initial configurations for yield source oracles
 @dev This function can only be used for first-time configuration setup
      For existing configurations, use proposeYieldSourceOracleConfig instead
      The caller becomes the manager for each new configuration
 @param salts Array of salt values to generate unique identifiers
 @param configs Array of initial oracle configurations to be created
