# Interface: IDebridgeGate

## Metadata

- **Name**: IDebridgeGate
- **Type**: Interface
- **Path**: lib/v2-core/lib/pigeon/src/debridge/interfaces/IDebridgeGate.sol

## Structs

### TokenInfo

```solidity
struct TokenInfo {
    uint256 nativeChainId;
    bytes nativeAddress;
}
```

### DebridgeInfo

```solidity
struct DebridgeInfo {
    uint256 chainId;
    uint256 maxAmount;
    uint256 balance;
    uint256 lockedInStrategies;
    address tokenAddress;
    uint16 minReservesBps;
    bool exist;
}
```

### DebridgeFeeInfo

```solidity
struct DebridgeFeeInfo {
    uint256 collectedFees;
    uint256 withdrawnFees;
    mapping(uint256 => uint256) getChainFee;
}
```

### ChainSupportInfo

```solidity
struct ChainSupportInfo {
    uint256 fixedNativeFee;
    bool isSupported;
    uint16 transferFeeBps;
}
```

### DiscountInfo

```solidity
struct DiscountInfo {
    uint16 discountFixBps;
    uint16 discountTransferBps;
}
```

### SubmissionAutoParamsTo

```solidity
/// @param executionFee Fee paid to the transaction executor.
///  @param fallbackAddress Receiver of the tokens if the call fails.
struct SubmissionAutoParamsTo {
    uint256 executionFee;
    uint256 flags;
    bytes fallbackAddress;
    bytes data;
}
```

### SubmissionAutoParamsFrom

```solidity
/// @param executionFee Fee paid to the transaction executor.
///  @param fallbackAddress Receiver of the tokens if the call fails.
struct SubmissionAutoParamsFrom {
    uint256 executionFee;
    uint256 flags;
    address fallbackAddress;
    bytes data;
    bytes nativeSender;
}
```

### FeeParams

```solidity
struct FeeParams {
    uint256 receivedAmount;
    uint256 fixFee;
    uint256 transferFee;
    bool useAssetFee;
    bool isNativeToken;
}
```

## Errors

### FeeProxyBadRole

```solidity
error FeeProxyBadRole();
```

### FeeContractUpdaterBadRole

```solidity
error FeeContractUpdaterBadRole();
```

### AdminBadRole

```solidity
error AdminBadRole();
```

### GovMonitoringBadRole

```solidity
error GovMonitoringBadRole();
```

### DebridgeNotFound

```solidity
error DebridgeNotFound();
```

### WrongChainTo

```solidity
error WrongChainTo();
```

### WrongChainFrom

```solidity
error WrongChainFrom();
```

### WrongArgument

```solidity
error WrongArgument();
```

### WrongAutoArgument

```solidity
error WrongAutoArgument();
```

### TransferAmountTooHigh

```solidity
error TransferAmountTooHigh();
```

### NotSupportedFixedFee

```solidity
error NotSupportedFixedFee();
```

### TransferAmountNotCoverFees

```solidity
error TransferAmountNotCoverFees();
```

### InvalidTokenToSend

```solidity
error InvalidTokenToSend();
```

### SubmissionUsed

```solidity
error SubmissionUsed();
```

### SubmissionBlocked

```solidity
error SubmissionBlocked();
```

### AssetAlreadyExist

```solidity
error AssetAlreadyExist();
```

### ZeroAddress

```solidity
error ZeroAddress();
```

### ProposedFeeTooHigh

```solidity
error ProposedFeeTooHigh();
```

### NotEnoughReserves

```solidity
error NotEnoughReserves();
```

### EthTransferFailed

```solidity
error EthTransferFailed();
```

## Events

### Sent

```solidity
/// @dev Emitted once the tokens are sent from the original(native) chain to the other chain; the transfer tokens
///  are expected to be claimed by the users.
event Sent(bytes32 submissionId, bytes32 indexed debridgeId, uint256 amount, bytes receiver, uint256 nonce, uint256 indexed chainIdTo, uint32 referralCode, FeeParams feeParams, bytes autoParams, address nativeSender);
```

### Claimed

```solidity
/// @dev Emitted once the tokens are transferred and withdrawn on a target chain
event Claimed(bytes32 submissionId, bytes32 indexed debridgeId, uint256 amount, address indexed receiver, uint256 nonce, uint256 indexed chainIdFrom, bytes autoParams, bool isNativeToken);
```

### PairAdded

```solidity
/// @dev Emitted when new asset support is added.
event PairAdded(bytes32 debridgeId, address tokenAddress, bytes nativeAddress, uint256 indexed nativeChainId, uint256 maxAmount, uint16 minReservesBps);
```

### MonitoringSendEvent

```solidity
event MonitoringSendEvent(bytes32 submissionId, uint256 nonce, uint256 lockedOrMintedAmount, uint256 totalSupply);
```

### MonitoringClaimEvent

```solidity
event MonitoringClaimEvent(bytes32 submissionId, uint256 lockedOrMintedAmount, uint256 totalSupply);
```

### ChainSupportUpdated

```solidity
/// @dev Emitted when the asset is allowed/disallowed to be transferred to the chain.
event ChainSupportUpdated(uint256 chainId, bool isSupported, bool isChainFrom);
```

### ChainsSupportUpdated

```solidity
/// @dev Emitted when the supported chains are updated.
event ChainsSupportUpdated(uint256 chainIds, ChainSupportInfo chainSupportInfo, bool isChainFrom);
```

### CallProxyUpdated

```solidity
/// @dev Emitted when the new call proxy is set.
event CallProxyUpdated(address callProxy);
```

### AutoRequestExecuted

```solidity
/// @dev Emitted when the transfer request is executed.
event AutoRequestExecuted(bytes32 submissionId, bool indexed success, address callProxy);
```

### Blocked

```solidity
/// @dev Emitted when a submission is blocked.
event Blocked(bytes32 submissionId);
```

### Unblocked

```solidity
/// @dev Emitted when a submission is unblocked.
event Unblocked(bytes32 submissionId);
```

### WithdrawnFee

```solidity
/// @dev Emitted when fee is withdrawn.
event WithdrawnFee(bytes32 debridgeId, uint256 fee);
```

### FixedNativeFeeUpdated

```solidity
/// @dev Emitted when globalFixedNativeFee and globalTransferFeeBps are updated.
event FixedNativeFeeUpdated(uint256 globalFixedNativeFee, uint256 globalTransferFeeBps);
```

### FixedNativeFeeAutoUpdated

```solidity
/// @dev Emitted when globalFixedNativeFee is updated by feeContractUpdater
event FixedNativeFeeAutoUpdated(uint256 globalFixedNativeFee);
```

## Public/External Functions

### isSubmissionUsed(bytes32)

- **Signature**: `isSubmissionUsed(bytes32)`
- **Visibility**: external
- **Source Range**: 2928:77:311

**Signature:**
```solidity
/// @dev Returns whether the transfer with the submissionId was claimed.
///  submissionId is generated in getSubmissionIdFrom
function isSubmissionUsed(bytes32 submissionId) external view returns (bool);;
```

### getNativeInfo(address)

- **Signature**: `getNativeInfo(address)`
- **Visibility**: external
- **Source Range**: 3075:112:311

**Signature:**
```solidity
/// @dev Returns native token info by wrapped token address
function getNativeInfo(address token) external view returns (uint256 nativeChainId, bytes memory nativeAddress);;
```

### callProxy()

- **Signature**: `callProxy()`
- **Visibility**: external
- **Source Range**: 3260:53:311

**Signature:**
```solidity
/// @dev Returns address of the proxy to execute user's calls.
function callProxy() external view returns (address);;
```

### globalFixedNativeFee()

- **Signature**: `globalFixedNativeFee()`
- **Visibility**: external
- **Source Range**: 3406:64:311

**Signature:**
```solidity
/// @dev Fallback fixed fee in native asset, used if a chain fixed fee is set to 0
function globalFixedNativeFee() external view returns (uint256);;
```

### globalTransferFeeBps()

- **Signature**: `globalTransferFeeBps()`
- **Visibility**: external
- **Source Range**: 3560:63:311

**Signature:**
```solidity
/// @dev Fallback transfer fee in BPS, used if a chain transfer fee is set to 0
function globalTransferFeeBps() external view returns (uint16);;
```

### getDebridge(bytes32)

- **Signature**: `getDebridge(bytes32)`
- **Visibility**: external
- **Source Range**: 3629:85:311

**Signature:**
```solidity
function getDebridge(bytes32 debridgeId) external view returns (DebridgeInfo memory);;
```

### setSignatureVerifier(address)

- **Signature**: `setSignatureVerifier(address)`
- **Visibility**: external
- **Source Range**: 3762:58:311

**Signature:**
```solidity
function setSignatureVerifier(address _verifier) external;;
```

### sendMessage(uint256,bytes,bytes)

- **Signature**: `sendMessage(uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 5080:189:311

**Signature:**
```solidity
/// @dev Submits the message to the deBridge infrastructure to be broadcasted to another supported blockchain (identified by _dstChainId)
///       with the instructions to call the _targetContractAddress contract using the given _targetContractCalldata
///  @notice NO ASSETS ARE BROADCASTED ALONG WITH THIS MESSAGE
///  @notice DeBridgeGate only accepts submissions with msg.value (native ether) covering a small protocol fee
///          (defined in the globalFixedNativeFee property). Any excess amount of ether passed to this function is
///          included in the message as the execution fee - the amount deBridgeGate would give as an incentive to
///          a third party in return for successful claim transaction execution on the destination chain.
///  @notice DeBridgeGate accepts a set of flags that control the behaviour of the execution. This simple method
///          sets the default set of flags: REVERT_IF_EXTERNAL_FAIL, PROXY_WITH_SENDER
///  @param _dstChainId ID of the destination chain.
///  @param _targetContractAddress A contract address to be called on the destination chain
///  @param _targetContractCalldata Calldata to execute against the target contract on the destination chain
function sendMessage(uint256 _dstChainId, bytes memory _targetContractAddress, bytes memory _targetContractCalldata) external payable returns (bytes32 submissionId);;
```

### sendMessage(uint256,bytes,bytes,uint256,uint32)

- **Signature**: `sendMessage(uint256,bytes,bytes,uint256,uint32)`
- **Visibility**: external
- **Source Range**: 6671:249:311

**Signature:**
```solidity
/// @dev Submits the message to the deBridge infrastructure to be broadcasted to another supported blockchain (identified by _dstChainId)
///       with the instructions to call the _targetContractAddress contract using the given _targetContractCalldata
///  @notice NO ASSETS ARE BROADCASTED ALONG WITH THIS MESSAGE
///  @notice DeBridgeGate only accepts submissions with msg.value (native ether) covering a small protocol fee
///          (defined in the globalFixedNativeFee property). Any excess amount of ether passed to this function is
///          included in the message as the execution fee - the amount deBridgeGate would give as an incentive to
///          a third party in return for successful claim transaction execution on the destination chain.
///  @notice DeBridgeGate accepts a set of flags that control the behaviour of the execution. This simple method
///          sets the default set of flags: REVERT_IF_EXTERNAL_FAIL, PROXY_WITH_SENDER
///  @param _dstChainId ID of the destination chain.
///  @param _targetContractAddress A contract address to be called on the destination chain
///  @param _targetContractCalldata Calldata to execute against the target contract on the destination chain
///  @param _flags A bitmask of toggles listed in the Flags library
///  @param _referralCode Referral code to identify this submission
function sendMessage(uint256 _dstChainId, bytes memory _targetContractAddress, bytes memory _targetContractCalldata, uint256 _flags, uint32 _referralCode) external payable returns (bytes32 submissionId);;
```

### send(address,uint256,uint256,bytes,bytes,bool,uint32,bytes)

- **Signature**: `send(address,uint256,uint256,bytes,bytes,bool,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 7775:315:311

**Signature:**
```solidity
/// @dev This method is used for the transfer of assets [from the native chain](https://docs.debridge.finance/the-core-protocol/transfers#transfer-from-native-chain).
///  It locks an asset in the smart contract in the native chain and enables minting of deAsset on the secondary chain.
///  @param _tokenAddress Asset identifier.
///  @param _amount Amount to be transferred (note: the fee can be applied).
///  @param _chainIdTo Chain id of the target chain.
///  @param _receiver Receiver address.
///  @param _permitEnvelope Permit for approving the spender by signature. bytes (amount + deadline + signature)
///  @param _useAssetFee use assets fee for pay protocol fix (work only for specials token)
///  @param _referralCode Referral code
///  @param _autoParams Auto params for external call in target network
function send(address _tokenAddress, uint256 _amount, uint256 _chainIdTo, bytes memory _receiver, bytes memory _permitEnvelope, bool _useAssetFee, uint32 _referralCode, bytes calldata _autoParams) external payable returns (bytes32 submissionId);;
```

### claim(bytes32,uint256,uint256,address,uint256,bytes,bytes)

- **Signature**: `claim(bytes32,uint256,uint256,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 8747:237:311

**Signature:**
```solidity
/// @dev Is used for transfers [into the native chain](https://docs.debridge.finance/the-core-protocol/transfers#transfer-from-secondary-chain-to-native-chain)
///  to unlock the designated amount of asset from collateral and transfer it to the receiver.
///  @param _debridgeId Asset identifier.
///  @param _amount Amount of the transferred asset (note: the fee can be applied).
///  @param _chainIdFrom Chain where submission was sent
///  @param _receiver Receiver address.
///  @param _nonce Submission id.
///  @param _signatures Validators signatures to confirm
///  @param _autoParams Auto params for external call
function claim(bytes32 _debridgeId, uint256 _amount, uint256 _chainIdFrom, address _receiver, uint256 _nonce, bytes calldata _signatures, bytes calldata _autoParams) external;;
```

### withdrawFee(bytes32)

- **Signature**: `withdrawFee(bytes32)`
- **Visibility**: external
- **Source Range**: 9084:51:311

**Signature:**
```solidity
/// @dev Withdraw collected fees to feeProxy
///  @param _debridgeId Asset identifier.
function withdrawFee(bytes32 _debridgeId) external;;
```

### getDebridgeChainAssetFixedFee(bytes32,uint256)

- **Signature**: `getDebridgeChainAssetFixedFee(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 9299:110:311

**Signature:**
```solidity
/// @dev Returns asset fixed fee value for specified debridge and chainId.
///  @param _debridgeId Asset identifier.
///  @param _chainId Chain id.
function getDebridgeChainAssetFixedFee(bytes32 _debridgeId, uint256 _chainId) external view returns (uint256);;
```
