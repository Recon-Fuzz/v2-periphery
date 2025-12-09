# Contract: SuperLedgerConfiguration

## Metadata

- **Name**: SuperLedgerConfiguration
- **Type**: Contract
- **Path**: lib/v2-core/src/accounting/SuperLedgerConfiguration.sol
- **Documentation**: @title SuperLedgerConfiguration
   @author Superform Labs
   @notice Configuration management contract for yield source oracles and ledgers
   @dev Manages oracle configurations, fee settings, and governance of changes
        Implements a proposal-acceptance pattern for configuration changes
        Provides role-based access control for managers of different yield sources

## Implements Interfaces

- **ISuperLedgerConfiguration** [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

## State Variables

### yieldSourceOracleConfig

```solidity
/// @notice Current active yield source oracle configurations
///  @dev Maps from oracle ID to its configuration including oracle address, fees, and management info
mapping(bytes32 => YieldSourceOracleConfig) private yieldSourceOracleConfig
```

### yieldSourceOracleConfigProposals

```solidity
/// @notice Proposed yield source oracle configurations pending acceptance
///  @dev Stores proposed configuration changes that must be accepted after a timelock period
mapping(bytes32 => YieldSourceOracleConfig) private yieldSourceOracleConfigProposals
```

### yieldSourceOracleConfigProposalGracePeriod

```solidity
/// @notice Timestamps for when proposals can be accepted
///  @dev Implements timelock period for configuration changes to allow for review
mapping(bytes32 => uint256) private yieldSourceOracleConfigProposalGracePeriod
```

### yieldSourceOracleIdsByOwner

```solidity
/// @notice Maps original owners to their yield source oracle IDs
///  @dev Used to track yield source oracle IDs by their original owners
mapping(address => bytes32[]) private yieldSourceOracleIdsByOwner
```

### pendingManager

```solidity
/// @notice Addresses nominated to receive manager role transfers
///  @dev Used in the two-step process for transferring management rights
mapping(bytes32 => address) private pendingManager
```

### MAX_FEE_PERCENT

```solidity
/// @notice Maximum allowed fee percentage (50% = 5000 basis points)
///  @dev Used to prevent setting excessive fees
uint256 internal constant MAX_FEE_PERCENT = 5000
```

### MAX_FEE_PERCENT_CHANGE

```solidity
/// @notice Maximum allowed fee percentage change (50% = 5000 basis points)
///  @dev Limits how much fees can be increased or decreased in a single proposal
///  @dev Allow fee percent change without validation when the new fee percentage is 0
uint256 internal constant MAX_FEE_PERCENT_CHANGE = 5000
```

### MAX_INITIAL_FEE_PERCENT

```solidity
/// @notice Maximum initial fee percentage (25% = 2500 basis points)
///  @dev Limits the initial fee percentage to 25%
uint256 internal constant MAX_INITIAL_FEE_PERCENT = 2500
```

### PROPOSAL_EXPIRATION_TIME

```solidity
/// @notice Duration of the timelock period for configuration proposals
///  @dev After this period elapses, proposals can be accepted
uint256 internal constant PROPOSAL_EXPIRATION_TIME = 1 weeks
```

## Structs

### YieldSourceOracleConfig (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Configuration for a yield source oracle
///  @dev Stored configuration for a particular yield source, identified by its ID elsewhere
struct YieldSourceOracleConfig {
    address yieldSourceOracle;
    uint256 feePercent;
    address feeRecipient;
    address manager;
    address ledger;
}
```

### YieldSourceOracleConfigArgs (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Input arguments for creating or updating a yield source oracle configuration
///  @dev Similar to YieldSourceOracleConfig but includes the ID and excludes the manager
///       The manager is either derived from existing config or set to msg.sender for new configs
struct YieldSourceOracleConfigArgs {
    address yieldSourceOracle;
    uint256 feePercent;
    address feeRecipient;
    address ledger;
}
```

## Errors

### NOT_MANAGER (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when a function restricted to managers is called by a non-manager address
error NOT_MANAGER();
```

### ZERO_LENGTH (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when providing an empty array where at least one element is required
error ZERO_LENGTH();
```

### CONFIG_EXISTS (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when attempting to create a configuration that already exists
error CONFIG_EXISTS();
```

### CONFIG_NOT_FOUND (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when referencing a configuration that doesn't exist
error CONFIG_NOT_FOUND();
```

### CANNOT_ACCEPT_YET (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when trying to accept a configuration proposal before the waiting period ends
error CANNOT_ACCEPT_YET();
```

### MANAGER_NOT_MATCHED (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when a manager mismatch is detected during configuration operations
error MANAGER_NOT_MATCHED();
```

### ZERO_ID_NOT_ALLOWED (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when a zero ID is provided for a configuration
error ZERO_ID_NOT_ALLOWED();
```

### INVALID_FEE_PERCENT (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when setting a fee percentage outside the allowed range (0-10000)
error INVALID_FEE_PERCENT();
```

### NO_PENDING_PROPOSAL (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when there is no pending proposal
error NO_PENDING_PROPOSAL();
```

### NOT_PENDING_MANAGER (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when attempting to accept a manager role without being the pending manager
error NOT_PENDING_MANAGER();
```

### CHANGE_ALREADY_PROPOSED (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when attempting to propose changes to a configuration that already has pending changes
error CHANGE_ALREADY_PROPOSED();
```

### ZERO_ADDRESS_NOT_ALLOWED (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when a critical address parameter is set to the zero address
error ZERO_ADDRESS_NOT_ALLOWED();
```

### LENGTH_MISMATCH (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Thrown when the length of input arrays do not match
error LENGTH_MISMATCH();
```

## Events

### YieldSourceOracleConfigSet (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when a new yield source oracle configuration is created
///  @param yieldSourceOracleId Unique identifier for the yield source oracle
///  @param yieldSourceOracle Address of the oracle contract
///  @param feePercent Fee percentage in basis points
///  @param manager Address with permission to update this configuration
///  @param feeRecipient Address that receives collected fees
///  @param ledger Address of the ledger contract using this configuration
event YieldSourceOracleConfigSet(bytes32 indexed yieldSourceOracleId, address indexed yieldSourceOracle, uint256 feePercent, address feeRecipient, address manager, address ledger);
```

### YieldSourceOracleConfigProposalSet (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when changes to a yield source oracle configuration are proposed
///  @param yieldSourceOracleId Unique identifier for the yield source oracle
///  @param yieldSourceOracle Proposed oracle contract address
///  @param feePercent Proposed fee percentage in basis points
///  @param manager Current manager address (unchanged during proposal)
///  @param feeRecipient Proposed fee recipient address
///  @param ledger Proposed ledger contract address
event YieldSourceOracleConfigProposalSet(bytes32 indexed yieldSourceOracleId, address indexed yieldSourceOracle, uint256 feePercent, address feeRecipient, address manager, address ledger);
```

### YieldSourceOracleConfigAccepted (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when proposed changes to a yield source oracle configuration are accepted
///  @param yieldSourceOracleId Unique identifier for the yield source oracle
///  @param yieldSourceOracle New oracle contract address
///  @param feePercent New fee percentage in basis points
///  @param manager Current manager address
///  @param feeRecipient New fee recipient address
///  @param ledger New ledger contract address
event YieldSourceOracleConfigAccepted(bytes32 indexed yieldSourceOracleId, address indexed yieldSourceOracle, uint256 feePercent, address feeRecipient, address manager, address ledger);
```

### ManagerRoleTransferStarted (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when the transfer of manager role is initiated
///  @param yieldSourceOracleId Unique identifier for the yield source oracle
///  @param currentManager Address of the current manager
///  @param newManager Address of the proposed new manager
event ManagerRoleTransferStarted(bytes32 indexed yieldSourceOracleId, address indexed currentManager, address indexed newManager);
```

### ManagerRoleTransferAccepted (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when the transfer of manager role is completed
///  @param yieldSourceOracleId Unique identifier for the yield source oracle
///  @param newManager Address of the new manager who accepted the role
event ManagerRoleTransferAccepted(bytes32 indexed yieldSourceOracleId, address indexed newManager);
```

### YieldSourceOracleConfigProposalCancelled (inherited from ISuperLedgerConfiguration)

```solidity
/// @notice Emitted when a yield source oracle configuration proposal is cancelled.
///  @param yieldSourceOracleId The identifier of the yield source oracle.
///  @param yieldSourceOracle The proposed oracle address.
///  @param feePercent The proposed fee percentage.
///  @param feeRecipient The proposed fee recipient.
///  @param manager The manager who proposed the change.
///  @param ledger The proposed ledger address.
event YieldSourceOracleConfigProposalCancelled(bytes32 indexed yieldSourceOracleId, address yieldSourceOracle, uint256 feePercent, address feeRecipient, address manager, address ledger);
```

## Public/External Functions

### setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])

- **Signature**: `setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])`
- **Visibility**: external
- **Source Range**: 3336:615:353
- **Details**: [function_setYieldSourceOracles_bytes32[]_struct_ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[].md](./function_setYieldSourceOracles_bytes32[]_struct_ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function setYieldSourceOracles(bytes32[] calldata salts, YieldSourceOracleConfigArgs[] calldata configs) virtual external;
```

### proposeYieldSourceOracleConfig(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])

- **Signature**: `proposeYieldSourceOracleConfig(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])`
- **Visibility**: external
- **Source Range**: 4003:2812:353
- **Details**: [function_proposeYieldSourceOracleConfig_bytes32[]_struct_ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[].md](./function_proposeYieldSourceOracleConfig_bytes32[]_struct_ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function proposeYieldSourceOracleConfig(bytes32[] calldata yieldSourceOracleIds, YieldSourceOracleConfigArgs[] calldata configs) virtual external;
```

### cancelYieldSourceOracleConfigProposal(bytes32)

- **Signature**: `cancelYieldSourceOracleConfigProposal(bytes32)`
- **Visibility**: external
- **Source Range**: 7039:1134:353
- **Details**: [function_cancelYieldSourceOracleConfigProposal_bytes32.md](./function_cancelYieldSourceOracleConfigProposal_bytes32.md)

**Signature:**
```solidity
/// @notice Cancels a pending yield source oracle configuration proposal.
///  @param yieldSourceOracleId The identifier of the yield source oracle.
///  @dev Only the current manager can call this function.
function cancelYieldSourceOracleConfigProposal(bytes32 yieldSourceOracleId) virtual external;
```

### acceptYieldSourceOracleConfigProposal(bytes32[])

- **Signature**: `acceptYieldSourceOracleConfigProposal(bytes32[])`
- **Visibility**: external
- **Source Range**: 8225:2153:353
- **Details**: [function_acceptYieldSourceOracleConfigProposal_bytes32[].md](./function_acceptYieldSourceOracleConfigProposal_bytes32[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function acceptYieldSourceOracleConfigProposal(bytes32[] calldata yieldSourceOracleIds) virtual external;
```

### transferManagerRole(bytes32,address)

- **Signature**: `transferManagerRole(bytes32,address)`
- **Visibility**: external
- **Source Range**: 10430:479:353
- **Details**: [function_transferManagerRole_bytes32_address.md](./function_transferManagerRole_bytes32_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function transferManagerRole(bytes32 yieldSourceOracleId, address newManager) virtual external;
```

### acceptManagerRole(bytes32)

- **Signature**: `acceptManagerRole(bytes32)`
- **Visibility**: external
- **Source Range**: 10961:376:353
- **Details**: [function_acceptManagerRole_bytes32.md](./function_acceptManagerRole_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function acceptManagerRole(bytes32 yieldSourceOracleId) virtual external;
```

### getAllYieldSourceOracleIdsByOwner(address)

- **Signature**: `getAllYieldSourceOracleIdsByOwner(address)`
- **Visibility**: external
- **Source Range**: 11573:165:353
- **Details**: [function_getAllYieldSourceOracleIdsByOwner_address.md](./function_getAllYieldSourceOracleIdsByOwner_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getAllYieldSourceOracleIdsByOwner(address owner) virtual external view returns (bytes32[] memory);
```

### getYieldSourceOracleConfig(bytes32)

- **Signature**: `getYieldSourceOracleConfig(bytes32)`
- **Visibility**: external
- **Source Range**: 11790:232:353
- **Details**: [function_getYieldSourceOracleConfig_bytes32.md](./function_getYieldSourceOracleConfig_bytes32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getYieldSourceOracleConfig(bytes32 yieldSourceOracleId) virtual external view returns (YieldSourceOracleConfig memory);
```

### getYieldSourceOracleConfigs(bytes32[])

- **Signature**: `getYieldSourceOracleConfigs(bytes32[])`
- **Visibility**: external
- **Source Range**: 12074:434:353
- **Details**: [function_getYieldSourceOracleConfigs_bytes32[].md](./function_getYieldSourceOracleConfigs_bytes32[].md)

**Signature:**
```solidity
/// @inheritdoc ISuperLedgerConfiguration
function getYieldSourceOracleConfigs(bytes32[] calldata yieldSourceOracleIds) virtual external view returns (YieldSourceOracleConfig[] memory configs);
```
