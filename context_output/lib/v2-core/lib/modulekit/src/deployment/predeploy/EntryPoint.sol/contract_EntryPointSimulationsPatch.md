# Contract: EntryPointSimulationsPatch

## Metadata

- **Name**: EntryPointSimulationsPatch
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol

## Implements Interfaces

- **IEntryPointSimulations** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPointSimulations.sol/interface_IEntryPointSimulations.md]
- **IERC165** [lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]
- **IEntryPoint** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]
- **INonceManager** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/INonceManager.sol/interface_INonceManager.md]
- **IStakeManager** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IStakeManager.sol/interface_IStakeManager.md]

## State Variables

### deposits (inherited from StakeManager)

```solidity
/// maps paymaster to their deposits and stakes
mapping(address => DepositInfo) public deposits
```

### nonceSequenceNumber (inherited from NonceManager)

```solidity
///  The next valid sequence number for a given nonce key.
mapping(address => mapping(uint192 => uint256)) public nonceSequenceNumber
```

### NOT_ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant NOT_ENTERED = 1
```

### ENTERED (inherited from ReentrancyGuard)

```solidity
uint256 private constant ENTERED = 2
```

### _status (inherited from ReentrancyGuard)

```solidity
uint256 private _status
```

### gasConsumed (inherited from GasDebug)

```solidity
mapping(address => mapping(uint256 => uint256)) internal gasConsumed
```

### _senderCreator (inherited from EntryPoint)

```solidity
SenderCreator private immutable _senderCreator = new SenderCreator()
```

**SenderCreator**: [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]

### INNER_GAS_OVERHEAD (inherited from EntryPoint)

```solidity
uint256 private constant INNER_GAS_OVERHEAD = 10000
```

### INNER_OUT_OF_GAS (inherited from EntryPoint)

```solidity
bytes32 private constant INNER_OUT_OF_GAS = hex"deaddead"
```

### INNER_REVERT_LOW_PREFUND (inherited from EntryPoint)

```solidity
bytes32 private constant INNER_REVERT_LOW_PREFUND = hex"deadaa51"
```

### REVERT_REASON_MAX_LEN (inherited from EntryPoint)

```solidity
uint256 private constant REVERT_REASON_MAX_LEN = 2048
```

### PENALTY_PERCENT (inherited from EntryPoint)

```solidity
uint256 private constant PENALTY_PERCENT = 10
```

### NOT_AGGREGATED (inherited from EntryPointSimulations)

```solidity
AggregatorStakeInfo private NOT_AGGREGATED = AggregatorStakeInfo(address(0), StakeInfo(0, 0))
```

### _senderCreator (inherited from EntryPointSimulations)

```solidity
SenderCreator private _senderCreator
```

**SenderCreator**: [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]

### _entrypointAddr

```solidity
address public _entrypointAddr = address(this)
```

### _newSenderCreator

```solidity
SenderCreator public _newSenderCreator
```

**SenderCreator**: [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/SenderCreator.sol/contract_SenderCreator.md]

## Structs

### DepositInfo (inherited from IStakeManager)

```solidity
///  @param deposit         - The entity's deposit.
///  @param staked          - True if this entity is staked.
///  @param stake           - Actual amount of ether staked for this entity.
///  @param unstakeDelaySec - Minimum delay to withdraw the stake.
///  @param withdrawTime    - First block timestamp where 'withdrawStake' will be callable, or zero if already locked.
///  @dev Sizes were chosen so that deposit fits into one cell (used during handleOp)
///       and the rest fit into a 2nd cell (used during stake/unstake)
///       - 112 bit allows for 10^15 eth
///       - 48 bit for full timestamp
///       - 32 bit allows 150 years for unstake delay
struct DepositInfo {
    uint256 deposit;
    bool staked;
    uint112 stake;
    uint32 unstakeDelaySec;
    uint48 withdrawTime;
}
```

### StakeInfo (inherited from IStakeManager)

```solidity
struct StakeInfo {
    uint256 stake;
    uint256 unstakeDelaySec;
}
```

### UserOpsPerAggregator (inherited from IEntryPoint)

```solidity
struct UserOpsPerAggregator {
    PackedUserOperation[] userOps;
    IAggregator aggregator;
    bytes signature;
}
```

### ReturnInfo (inherited from IEntryPoint)

```solidity
///  Gas and return values during simulation.
///  @param preOpGas         - The gas used for validation (including preValidationGas)
///  @param prefund          - The required prefund for this operation
///  @param accountValidationData   - returned validationData from account.
///  @param paymasterValidationData - return validationData from paymaster.
///  @param paymasterContext - Returned by validatePaymasterUserOp (to be passed into postOp)
struct ReturnInfo {
    uint256 preOpGas;
    uint256 prefund;
    uint256 accountValidationData;
    uint256 paymasterValidationData;
    bytes paymasterContext;
}
```

### AggregatorStakeInfo (inherited from IEntryPoint)

```solidity
///  Returned aggregated signature info:
///  The aggregator returned by the account, and its current stake.
struct AggregatorStakeInfo {
    address aggregator;
    StakeInfo stakeInfo;
}
```

### MemoryUserOp (inherited from EntryPoint)

```solidity
///  A memory copy of UserOp static fields only.
///  Excluding: callData, initCode and signature. Replacing paymasterAndData with paymaster.
struct MemoryUserOp {
    address sender;
    uint256 nonce;
    uint256 verificationGasLimit;
    uint256 callGasLimit;
    uint256 paymasterVerificationGasLimit;
    uint256 paymasterPostOpGasLimit;
    uint256 preVerificationGas;
    address paymaster;
    uint256 maxFeePerGas;
    uint256 maxPriorityFeePerGas;
}
```

### UserOpInfo (inherited from EntryPoint)

```solidity
struct UserOpInfo {
    MemoryUserOp mUserOp;
    bytes32 userOpHash;
    uint256 prefund;
    uint256 contextOffset;
    uint256 preOpGas;
}
```

### ExecutionResult (inherited from IEntryPointSimulations)

```solidity
struct ExecutionResult {
    uint256 preOpGas;
    uint256 paid;
    uint256 accountValidationData;
    uint256 paymasterValidationData;
    bool targetSuccess;
    bytes targetResult;
}
```

### ValidationResult (inherited from IEntryPointSimulations)

```solidity
///  Successful result from simulateValidation.
///  If the account returns a signature aggregator the "aggregatorInfo" struct is filled in as well.
///  @param returnInfo     Gas and time-range returned values
///  @param senderInfo     Stake information about the sender
///  @param factoryInfo    Stake information about the factory (if any)
///  @param paymasterInfo  Stake information about the paymaster (if any)
///  @param aggregatorInfo Signature aggregation info (if the account requires signature aggregator)
///                        Bundler MUST use it to verify the signature, or reject the UserOperation.
struct ValidationResult {
    ReturnInfo returnInfo;
    StakeInfo senderInfo;
    StakeInfo factoryInfo;
    StakeInfo paymasterInfo;
    AggregatorStakeInfo aggregatorInfo;
}
```

## Errors

### FailedOp (inherited from IEntryPoint)

```solidity
///  A custom revert error of handleOps, to identify the offending op.
///  Should be caught in off-chain handleOps simulation and not happen on-chain.
///  Useful for mitigating DoS attempts against batchers or for troubleshooting of factory/account/paymaster reverts.
///  NOTE: If simulateValidation passes successfully, there should be no reason for handleOps to fail on it.
///  @param opIndex - Index into the array of ops to the failed one (in simulateValidation, this is always zero).
///  @param reason  - Revert reason. The string starts with a unique code "AAmn",
///                   where "m" is "1" for factory, "2" for account and "3" for paymaster issues,
///                   so a failure can be attributed to the correct entity.
error FailedOp(uint256 opIndex, string reason);
```

### FailedOpWithRevert (inherited from IEntryPoint)

```solidity
///  A custom revert error of handleOps, to report a revert by account or paymaster.
///  @param opIndex - Index into the array of ops to the failed one (in simulateValidation, this is always zero).
///  @param reason  - Revert reason. see FailedOp(uint256,string), above
///  @param inner   - data from inner cought revert reason
///  @dev note that inner is truncated to 2048 bytes
error FailedOpWithRevert(uint256 opIndex, string reason, bytes inner);
```

### PostOpReverted (inherited from IEntryPoint)

```solidity
error PostOpReverted(bytes returnData);
```

### SignatureValidationFailed (inherited from IEntryPoint)

```solidity
///  Error case when a signature aggregator fails to verify the aggregated signature it had created.
///  @param aggregator The aggregator that failed to verify the signature
error SignatureValidationFailed(address aggregator);
```

### SenderAddressResult (inherited from IEntryPoint)

```solidity
error SenderAddressResult(address sender);
```

### DelegateAndRevert (inherited from IEntryPoint)

```solidity
error DelegateAndRevert(bool success, bytes ret);
```

### ReentrancyGuardReentrantCall (inherited from ReentrancyGuard)

```solidity
///  @dev Unauthorized reentrant call.
error ReentrancyGuardReentrantCall();
```

## Events

### Deposited (inherited from IStakeManager)

```solidity
event Deposited(address indexed account, uint256 totalDeposit);
```

### Withdrawn (inherited from IStakeManager)

```solidity
event Withdrawn(address indexed account, address withdrawAddress, uint256 amount);
```

### StakeLocked (inherited from IStakeManager)

```solidity
event StakeLocked(address indexed account, uint256 totalStaked, uint256 unstakeDelaySec);
```

### StakeUnlocked (inherited from IStakeManager)

```solidity
event StakeUnlocked(address indexed account, uint256 withdrawTime);
```

### StakeWithdrawn (inherited from IStakeManager)

```solidity
event StakeWithdrawn(address indexed account, address withdrawAddress, uint256 amount);
```

### UserOperationEvent (inherited from IEntryPoint)

```solidity
event UserOperationEvent(bytes32 indexed userOpHash, address indexed sender, address indexed paymaster, uint256 nonce, bool success, uint256 actualGasCost, uint256 actualGasUsed);
```

### AccountDeployed (inherited from IEntryPoint)

```solidity
///  Account "sender" was deployed.
///  @param userOpHash - The userOp that deployed this account. UserOperationEvent will follow.
///  @param sender     - The account that is deployed
///  @param factory    - The factory used to deploy this account (in the initCode)
///  @param paymaster  - The paymaster used by this UserOp
event AccountDeployed(bytes32 indexed userOpHash, address indexed sender, address factory, address paymaster);
```

### UserOperationRevertReason (inherited from IEntryPoint)

```solidity
///  An event emitted if the UserOperation "callData" reverted with non-zero length.
///  @param userOpHash   - The request unique identifier.
///  @param sender       - The sender of this request.
///  @param nonce        - The nonce used in the request.
///  @param revertReason - The return bytes from the (reverted) call to "callData".
event UserOperationRevertReason(bytes32 indexed userOpHash, address indexed sender, uint256 nonce, bytes revertReason);
```

### PostOpRevertReason (inherited from IEntryPoint)

```solidity
///  An event emitted if the UserOperation Paymaster's "postOp" call reverted with non-zero length.
///  @param userOpHash   - The request unique identifier.
///  @param sender       - The sender of this request.
///  @param nonce        - The nonce used in the request.
///  @param revertReason - The return bytes from the (reverted) call to "callData".
event PostOpRevertReason(bytes32 indexed userOpHash, address indexed sender, uint256 nonce, bytes revertReason);
```

### UserOperationPrefundTooLow (inherited from IEntryPoint)

```solidity
///  UserOp consumed more than prefund. The UserOperation is reverted, and no refund is made.
///  @param userOpHash   - The request unique identifier.
///  @param sender       - The sender of this request.
///  @param nonce        - The nonce used in the request.
event UserOperationPrefundTooLow(bytes32 indexed userOpHash, address indexed sender, uint256 nonce);
```

### BeforeExecution (inherited from IEntryPoint)

```solidity
///  An event emitted by handleOps(), before starting the execution loop.
///  Any event emitted before this event, is part of the validation.
event BeforeExecution();
```

### SignatureAggregatorChanged (inherited from IEntryPoint)

```solidity
///  Signature aggregator used by the following UserOperationEvents within this bundle.
///  @param aggregator - The aggregator used for the following UserOperationEvents.
event SignatureAggregatorChanged(address indexed aggregator);
```

## Public/External Functions

### init(address)

- **Signature**: `init(address)`
- **Visibility**: public
- **Source Range**: 595:123:187
- **Details**: [function_init_address.md](./function_init_address.md)

**Signature:**
```solidity
function init(address entrypointAddr) public;
```

### getDepositInfo(address) (inherited from StakeManager)

- **Signature**: `getDepositInfo(address)`
- **Visibility**: public
- **Source Range**: 595:142:95
- **Details**: [function_getDepositInfo_address.md](./function_getDepositInfo_address.md)

**Signature:**
```solidity
/// @inheritdoc IStakeManager
function getDepositInfo(address account) public view returns (DepositInfo memory info);
```

### balanceOf(address) (inherited from StakeManager)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1158:115:95
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @inheritdoc IStakeManager
function balanceOf(address account) public view returns (uint256);
```

### receive() (inherited from StakeManager)

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 1279:65:95
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```

### depositTo(address) (inherited from StakeManager)

- **Signature**: `depositTo(address)`
- **Visibility**: public
- **Source Range**: 1935:179:95
- **Details**: [function_depositTo_address.md](./function_depositTo_address.md)

**Signature:**
```solidity
///  Add to the deposit of the given account.
///  @param account - The account to add to.
function depositTo(address account) virtual public payable;
```

### addStake(uint32) (inherited from StakeManager)

- **Signature**: `addStake(uint32)`
- **Visibility**: public
- **Source Range**: 2325:706:95
- **Details**: [function_addStake_uint32.md](./function_addStake_uint32.md)

**Signature:**
```solidity
///  Add to the account's stake - amount and delay
///  any pending unstake is first cancelled.
///  @param unstakeDelaySec The new lock duration before the deposit can be withdrawn.
function addStake(uint32 unstakeDelaySec) public payable;
```

### unlockStake() (inherited from StakeManager)

- **Signature**: `unlockStake()`
- **Visibility**: external
- **Source Range**: 3170:408:95
- **Details**: [function_unlockStake.md](./function_unlockStake.md)

**Signature:**
```solidity
///  Attempt to unlock the stake.
///  The value can be withdrawn (using withdrawStake) after the unstake delay.
function unlockStake() external;
```

### withdrawStake(address payable) (inherited from StakeManager)

- **Signature**: `withdrawStake(address payable)`
- **Visibility**: external
- **Source Range**: 3786:684:95
- **Details**: [function_withdrawStake_address_payable.md](./function_withdrawStake_address_payable.md)

**Signature:**
```solidity
///  Withdraw from the (unlocked) stake.
///  Must first call unlockStake and wait for the unstakeDelay to pass.
///  @param withdrawAddress - The address to send withdrawn value.
function withdrawStake(address payable withdrawAddress) external;
```

### withdrawTo(address payable,uint256) (inherited from StakeManager)

- **Signature**: `withdrawTo(address payable,uint256)`
- **Visibility**: external
- **Source Range**: 4651:496:95
- **Details**: [function_withdrawTo_address_payable_uint256.md](./function_withdrawTo_address_payable_uint256.md)

**Signature:**
```solidity
///  Withdraw from the deposit.
///  @param withdrawAddress - The address to send withdrawn value.
///  @param withdrawAmount  - The amount to withdraw.
function withdrawTo(address payable withdrawAddress, uint256 withdrawAmount) external;
```

### getNonce(address,uint192) (inherited from NonceManager)

- **Signature**: `getNonce(address,uint192)`
- **Visibility**: public
- **Source Range**: 394:175:93
- **Details**: [function_getNonce_address_uint192.md](./function_getNonce_address_uint192.md)

**Signature:**
```solidity
/// @inheritdoc INonceManager
function getNonce(address sender, uint192 key) override public view returns (uint256 nonce);
```

### incrementNonce(uint192) (inherited from NonceManager)

- **Signature**: `incrementNonce(uint192)`
- **Visibility**: public
- **Source Range**: 830:108:93
- **Details**: [function_incrementNonce_uint192.md](./function_incrementNonce_uint192.md)

**Signature:**
```solidity
function incrementNonce(uint192 key) override public;
```

### supportsInterface(bytes4) (inherited from ERC165)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 730:146:292
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @inheritdoc IERC165
function supportsInterface(bytes4 interfaceId) virtual public view returns (bool);
```

### getGasConsumed(address,uint256) (inherited from GasDebug)

- **Signature**: `getGasConsumed(address,uint256)`
- **Visibility**: public
- **Source Range**: 390:137:91
- **Details**: [function_getGasConsumed_address_uint256.md](./function_getGasConsumed_address_uint256.md)

**Signature:**
```solidity
function getGasConsumed(address account, uint256 phase) public view returns (uint256);
```

### handleOps(struct PackedUserOperation[],address payable) (inherited from EntryPoint)

- **Signature**: `handleOps(struct PackedUserOperation[],address payable)`
- **Visibility**: public
- **Source Range**: 6605:837:89
- **Details**: [function_handleOps_struct_PackedUserOperation[]_address_payable.md](./function_handleOps_struct_PackedUserOperation[]_address_payable.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPoint
function handleOps(PackedUserOperation[] calldata ops, address payable beneficiary) public nonReentrant();
```

### handleAggregatedOps(struct IEntryPoint.UserOpsPerAggregator[],address payable) (inherited from EntryPoint)

- **Signature**: `handleAggregatedOps(struct IEntryPoint.UserOpsPerAggregator[],address payable)`
- **Visibility**: public
- **Source Range**: 7480:2459:89
- **Details**: [function_handleAggregatedOps_struct_IEntryPoint_UserOpsPerAggregator[]_address_payable.md](./function_handleAggregatedOps_struct_IEntryPoint_UserOpsPerAggregator[]_address_payable.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPoint
function handleAggregatedOps(UserOpsPerAggregator[] calldata opsPerAggregator, address payable beneficiary) public nonReentrant();
```

### innerHandleOp(bytes,struct EntryPoint.UserOpInfo,bytes) (inherited from EntryPoint)

- **Signature**: `innerHandleOp(bytes,struct EntryPoint.UserOpInfo,bytes)`
- **Visibility**: external
- **Source Range**: 11037:1587:89
- **Details**: [function_innerHandleOp_bytes_struct_EntryPoint_UserOpInfo_bytes.md](./function_innerHandleOp_bytes_struct_EntryPoint_UserOpInfo_bytes.md)

**Signature:**
```solidity
///  Inner function to handle a UserOperation.
///  Must be declared "external" to open a call context, but it can only be called by handleOps.
///  @param callData - The callData to execute.
///  @param opInfo   - The UserOpInfo struct.
///  @param context  - The context bytes.
///  @return actualGasCost - the actual cost in eth this UserOperation paid for gas
function innerHandleOp(bytes memory callData, UserOpInfo memory opInfo, bytes calldata context) external returns (uint256 actualGasCost);
```

### getUserOpHash(struct PackedUserOperation) (inherited from EntryPoint)

- **Signature**: `getUserOpHash(struct PackedUserOperation)`
- **Visibility**: public
- **Source Range**: 12662:180:89
- **Details**: [function_getUserOpHash_struct_PackedUserOperation.md](./function_getUserOpHash_struct_PackedUserOperation.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPoint
function getUserOpHash(PackedUserOperation calldata userOp) public view returns (bytes32);
```

### getSenderAddress(bytes) (inherited from EntryPoint)

- **Signature**: `getSenderAddress(bytes)`
- **Visibility**: public
- **Source Range**: 16083:174:89
- **Details**: [function_getSenderAddress_bytes.md](./function_getSenderAddress_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPoint
function getSenderAddress(bytes calldata initCode) public;
```

### delegateAndRevert(address,bytes) (inherited from EntryPoint)

- **Signature**: `delegateAndRevert(address,bytes)`
- **Visibility**: external
- **Source Range**: 29869:198:89
- **Details**: [function_delegateAndRevert_address_bytes.md](./function_delegateAndRevert_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPoint
function delegateAndRevert(address target, bytes calldata data) external;
```

### constructor() (inherited from EntryPointSimulations)

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 1607:241:90
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
///  simulation contract should not be deployed, and specifically, accounts should not trust
///  it as entrypoint, since the simulation functions don't check the signatures
constructor();
```

### simulateValidation(struct PackedUserOperation) (inherited from EntryPointSimulations)

- **Signature**: `simulateValidation(struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 1897:1671:90
- **Details**: [function_simulateValidation_struct_PackedUserOperation.md](./function_simulateValidation_struct_PackedUserOperation.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPointSimulations
function simulateValidation(PackedUserOperation calldata userOp) external returns (ValidationResult memory);
```

### simulateHandleOp(struct PackedUserOperation,address,bytes) (inherited from EntryPointSimulations)

- **Signature**: `simulateHandleOp(struct PackedUserOperation,address,bytes)`
- **Visibility**: external
- **Source Range**: 3617:875:90
- **Details**: [function_simulateHandleOp_struct_PackedUserOperation_address_bytes.md](./function_simulateHandleOp_struct_PackedUserOperation_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IEntryPointSimulations
function simulateHandleOp(PackedUserOperation calldata op, address target, bytes calldata targetCallData) external nonReentrant() returns (ExecutionResult memory);
```

### _validateSenderAndPaymaster(bytes,address,bytes) (inherited from EntryPointSimulations)

- **Signature**: `_validateSenderAndPaymaster(bytes,address,bytes)`
- **Visibility**: external
- **Source Range**: 5490:718:90
- **Details**: [function__validateSenderAndPaymaster_bytes_address_bytes.md](./function__validateSenderAndPaymaster_bytes_address_bytes.md)

**Signature:**
```solidity
///  Called only during simulation.
///  This function always reverts to prevent warm/cold storage differentiation in simulation vs execution.
///  @param initCode         - The smart account constructor code.
///  @param sender           - The sender address.
///  @param paymasterAndData - The paymaster address (followed by other params, ignored by this method)
function _validateSenderAndPaymaster(bytes calldata initCode, address sender, bytes calldata paymasterAndData) external view;
```
