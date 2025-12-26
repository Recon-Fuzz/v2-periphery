# Contract: ECDSAPPSOracle

## Metadata

- **Name**: ECDSAPPSOracle
- **Type**: Contract
- **Path**: src/oracles/ECDSAPPSOracle.sol
- **Documentation**: @title ECDSAPPSOracle
   @author Superform Labs
   @notice PPS Oracle that validates price updates using ECDSA signatures
   @dev Implements the IECDSAPPSOracle interface for validating and forwarding PPS updates

## Implements Interfaces

- **IERC5267** [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **IECDSAPPSOracle** [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]

## State Variables

### TYPE_HASH (inherited from EIP712)

```solidity
bytes32 private constant TYPE_HASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
```

### _cachedDomainSeparator (inherited from EIP712)

```solidity
bytes32 private immutable _cachedDomainSeparator
```

### _cachedChainId (inherited from EIP712)

```solidity
uint256 private immutable _cachedChainId
```

### _cachedThis (inherited from EIP712)

```solidity
address private immutable _cachedThis
```

### _hashedName (inherited from EIP712)

```solidity
bytes32 private immutable _hashedName
```

### _hashedVersion (inherited from EIP712)

```solidity
bytes32 private immutable _hashedVersion
```

### _name (inherited from EIP712)

```solidity
ShortString private immutable _name
```

### _version (inherited from EIP712)

```solidity
ShortString private immutable _version
```

### _nameFallback (inherited from EIP712)

```solidity
string private _nameFallback
```

### _versionFallback (inherited from EIP712)

```solidity
string private _versionFallback
```

### noncePerStrategy

```solidity
mapping(address => uint256) public noncePerStrategy
```

### MAX_STRATEGIES

```solidity
/// @notice Maximum number of strategies that can be processed in a single batch
///  @dev Set to 300 to stay well below gas limits while allowing efficient batch updates.
uint256 public constant MAX_STRATEGIES = 300
```

### SUPER_GOVERNOR

```solidity
/// @notice The SuperGovernor contract for validator verification
ISuperGovernor public immutable SUPER_GOVERNOR
```

**ISuperGovernor**: [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

### UPDATE_PPS_TYPEHASH

```solidity
/// @notice EIP-712 typehash for PPS update signatures
///  @dev Defines the structure: UpdatePPS(address strategy, uint256 pps, uint256 timestamp, uint256 strategyNonce)
///       - strategy: The strategy contract address
///       - pps: The price-per-share value being signed
///       - timestamp: The blockchain state timestamp this PPS represents
///       - strategyNonce: Current nonce for this strategy (prevents replay attacks)
///       This typehash MUST match the off-chain signing format exactly. Changing this typehash would
///       invalidate all existing signatures. See Property 1 in security_properties.md for nonce details.
bytes32 public constant UPDATE_PPS_TYPEHASH = keccak256("UpdatePPS(address strategy,uint256 pps,uint256 timestamp,uint256 strategyNonce)")
```

### SUPER_VAULT_AGGREGATOR

```solidity
bytes32 private constant SUPER_VAULT_AGGREGATOR = keccak256("SUPER_VAULT_AGGREGATOR")
```

## Structs

### ValidationParams (inherited from IECDSAPPSOracle)

```solidity
/// @notice Parameters for validating PPS proofs
///  @param strategy Address of the strategy
///  @param proofs Array of cryptographic proofs
///  @param pps Price-per-share value
///  @param timestamp Timestamp when the value was generated
struct ValidationParams {
    address strategy;
    bytes[] proofs;
    uint256 pps;
    uint256 timestamp;
}
```

### UpdatePPSArgs (inherited from IECDSAPPSOracle)

```solidity
/// @notice Arguments for batch updating PPS for multiple strategies
///  @param strategies Array of strategy addresses
///  @param proofsArray Array of arrays of cryptographic proofs (one array of proofs per strategy)
///  @param ppss Array of price-per-share values
///  @param timestamps The time and therefore the blockchain(s) state(s) (plural important) this PPS refers to
struct UpdatePPSArgs {
    address[] strategies;
    bytes[][] proofsArray;
    uint256[] ppss;
    uint256[] timestamps;
}
```

### ValidatedBatchData (inherited from IECDSAPPSOracle)

```solidity
/// @notice Struct to avoid stack too deep errors in batch processing
struct ValidatedBatchData {
    address[] strategies;
    uint256[] ppss;
    uint256[] timestamps;
    uint256[] validatorSets;
}
```

## Errors

### INVALID_PROOF (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the proof is invalid or cannot be verified
error INVALID_PROOF();
```

### INVALID_VALIDATOR (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when a validator is not registered or authorized
error INVALID_VALIDATOR();
```

### QUORUM_NOT_MET (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the quorum of validators is not met
error QUORUM_NOT_MET();
```

### ARRAY_LENGTH_MISMATCH (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the input arrays have different lengths
error ARRAY_LENGTH_MISMATCH();
```

### ZERO_LENGTH_ARRAY (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the input array is empty
error ZERO_LENGTH_ARRAY();
```

### INVALID_TIMESTAMP (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the timestamp in the proof is invalid
error INVALID_TIMESTAMP();
```

### HIGH_PPS_DEVIATION (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the deviation from previous PPS is too high
error HIGH_PPS_DEVIATION();
```

### INVALID_TOTAL_VALIDATORS (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the totalValidators doesn't match the actual total number of validators
error INVALID_TOTAL_VALIDATORS();
```

### INSUFFICIENT_GAS_FOR_EXTERNAL_CALL (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the gas provided is insufficient for external calls
error INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
```

### MAX_STRATEGIES_EXCEEDED (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when the number of strategies exceeds the maximum allowed
error MAX_STRATEGIES_EXCEEDED();
```

### STRATEGIES_NOT_SORTED_UNIQUE (inherited from IECDSAPPSOracle)

```solidity
/// @notice Thrown when strategies are not sorted in ascending order or contain duplicates
error STRATEGIES_NOT_SORTED_UNIQUE();
```

## Events

### PPSValidated (inherited from IECDSAPPSOracle)

```solidity
/// @notice Emitted when a PPS update is validated and forwarded
///  @param strategy Address of the strategy
///  @param pps The validated price-per-share value
///  @param timestamp Timestamp when the value was generated
///  @param sender Address that submitted the update
event PPSValidated(address indexed strategy, uint256 pps, uint256 timestamp, address indexed sender);
```

### ProofValidationFailed (inherited from IECDSAPPSOracle)

```solidity
/// @notice Emitted when proof validation failed
///  @param strategy Address of the strategy
///  @param reason Revert reason
event ProofValidationFailed(address indexed strategy, string reason);
```

### ProofValidationFailedLowLevel (inherited from IECDSAPPSOracle)

```solidity
/// @notice Emitted when proof validation failed
///  @param strategy Address of the strategy
///  @param data Revert encoded data
event ProofValidationFailedLowLevel(address indexed strategy, bytes data);
```

### BatchForwardPPSFailed (inherited from IECDSAPPSOracle)

```solidity
/// @notice Emitted when batch forward PPS failed
///  @param reason Revert reason
event BatchForwardPPSFailed(string reason);
```

### BatchForwardPPSFailedLowLevel (inherited from IECDSAPPSOracle)

```solidity
/// @notice Emitted when batch forward PPS failed
///  @param lowLevelData Revert encoded data
event BatchForwardPPSFailedLowLevel(bytes lowLevelData);
```

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

## Public/External Functions

### constructor(address,string,string)

- **Signature**: `constructor(address,string,string)`
- **Visibility**: public
- **Source Range**: 3093:240:532
- **Details**: [function_constructor_address_string_string.md](./function_constructor_address_string_string.md)

**Signature:**
```solidity
/// @notice Initializes the ECDSAPPSOracle contract
///  @param superGovernor_ Address of the SuperGovernor contract
///  @param name_ EIP-712 domain name (e.g., "SuperformOraclePPS"). Used for domain separation.
///  @param version_ EIP-712 domain version (e.g., "1"). Must match off-chain signing version.
///  @dev The name_ and version_ parameters define the EIP-712 domain separator and cannot be changed
///       after deployment. All validator signatures must be signed with matching domain parameters.
constructor(address superGovernor_, string memory name_, string memory version_) EIP712(name_,version_);
```

### domainSeparator()

- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 3558:103:532
- **Details**: [function_domainSeparator.md](./function_domainSeparator.md)

**Signature:**
```solidity
/// @inheritdoc IECDSAPPSOracle
function domainSeparator() external view returns (bytes32);
```

### updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)

- **Signature**: `updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)`
- **Visibility**: external
- **Source Range**: 3887:1407:532
- **Details**: [function_updatePPS_struct_IECDSAPPSOracle_UpdatePPSArgs.md](./function_updatePPS_struct_IECDSAPPSOracle_UpdatePPSArgs.md)

**Signature:**
```solidity
/// @inheritdoc IECDSAPPSOracle
function updatePPS(UpdatePPSArgs calldata args) external;
```

### validateProofs(struct IECDSAPPSOracle.ValidationParams)

- **Signature**: `validateProofs(struct IECDSAPPSOracle.ValidationParams)`
- **Visibility**: external
- **Source Range**: 5421:248:532
- **Details**: [function_validateProofs_struct_IECDSAPPSOracle_ValidationParams.md](./function_validateProofs_struct_IECDSAPPSOracle_ValidationParams.md)

**Signature:**
```solidity
/// @inheritdoc IECDSAPPSOracle
///  @dev Reverts immediately if duplicate signers are found or quorum is not met
function validateProofs(IECDSAPPSOracle.ValidationParams memory params) external view;
```

### validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)

- **Signature**: `validateProofs(struct IECDSAPPSOracle.ValidationParams,uint256)`
- **Visibility**: public
- **Source Range**: 5796:164:532
- **Details**: [function_validateProofs_struct_IECDSAPPSOracle_ValidationParams_uint256.md](./function_validateProofs_struct_IECDSAPPSOracle_ValidationParams_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IECDSAPPSOracle
///  @dev Reverts immediately if duplicate signers are found or quorum is not met
function validateProofs(IECDSAPPSOracle.ValidationParams memory params, uint256 requiredQuorum) public view;
```

### eip712Domain() (inherited from EIP712)

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5228:557:288
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
/// @inheritdoc IERC5267
function eip712Domain() virtual public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
```
