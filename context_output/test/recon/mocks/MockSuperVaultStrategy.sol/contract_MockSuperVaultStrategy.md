# Contract: MockSuperVaultStrategy

## Metadata

- **Name**: MockSuperVaultStrategy
- **Type**: Contract
- **Path**: test/recon/mocks/MockSuperVaultStrategy.sol

## State Variables

### _PRECISIONReturn_0

```solidity
uint256 private _PRECISIONReturn_0
```

### _claimableWithdrawReturn_0

```solidity
uint256 private _claimableWithdrawReturn_0
```

### _containsYieldSourceReturn_0

```solidity
bool private _containsYieldSourceReturn_0
```

### _emergencyWithdrawableReturn_0

```solidity
bool private _emergencyWithdrawableReturn_0
```

### _emergencyWithdrawableEffectiveTimeReturn_0

```solidity
uint256 private _emergencyWithdrawableEffectiveTimeReturn_0
```

### _getAverageWithdrawPriceReturn_0

```solidity
uint256 private _getAverageWithdrawPriceReturn_0
```

### _getConfigInfoReturn_0

```solidity
ISuperVaultStrategy_FeeConfig private _getConfigInfoReturn_0
```

### _getStoredPPSReturn_0

```solidity
uint256 private _getStoredPPSReturn_0
```

### _getSuperVaultStateReturn_0

```solidity
ISuperVaultStrategy_SuperVaultState private _getSuperVaultStateReturn_0
```

### _getVaultInfoReturn_0

```solidity
address private _getVaultInfoReturn_0
```

### _getVaultInfoReturn_1

```solidity
address private _getVaultInfoReturn_1
```

### _getVaultInfoReturn_2

```solidity
uint8 private _getVaultInfoReturn_2
```

### _getYieldSourceReturn_0

```solidity
ISuperVaultStrategy_YieldSource private _getYieldSourceReturn_0
```

### _getYieldSourcesReturn_0

```solidity
address[] private _getYieldSourcesReturn_0
```

### _getYieldSourcesCountReturn_0

```solidity
uint256 private _getYieldSourcesCountReturn_0
```

### _getYieldSourcesListReturn_0

```solidity
ISuperVaultStrategy_YieldSourceInfo[] private _getYieldSourcesListReturn_0
```

### _handleOperations4626DepositReturn_0

```solidity
uint256 private _handleOperations4626DepositReturn_0
```

### _pendingRedeemRequestReturn_0

```solidity
uint256 private _pendingRedeemRequestReturn_0
```

### _previewPerformanceFeeReturn_0

```solidity
uint256 private _previewPerformanceFeeReturn_0
```

### _previewPerformanceFeeReturn_1

```solidity
uint256 private _previewPerformanceFeeReturn_1
```

### _previewPerformanceFeeReturn_2

```solidity
uint256 private _previewPerformanceFeeReturn_2
```

### _proposedEmergencyWithdrawableReturn_0

```solidity
bool private _proposedEmergencyWithdrawableReturn_0
```

### _quoteMintAssetsGrossReturn_0

```solidity
uint256 private _quoteMintAssetsGrossReturn_0
```

### _quoteMintAssetsGrossReturn_1

```solidity
uint256 private _quoteMintAssetsGrossReturn_1
```

### _superGovernorReturn_0

```solidity
address private _superGovernorReturn_0
```

## Structs

### ISuperVaultStrategy_ExecuteArgs

```solidity
///    ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️  *
///  -----------------------------------------------------------------*
///       Generally you only need to modify the sections above.      *
///           The code below handles system operations.              *
struct ISuperVaultStrategy_ExecuteArgs {
    address[] hooks;
    bytes[] hookCalldata;
    uint256[] expectedAssetsOrSharesOut;
    bytes32[][] globalProofs;
    bytes32[][] strategyProofs;
}
```

### ISuperVaultStrategy_FeeConfig

```solidity
struct ISuperVaultStrategy_FeeConfig {
    uint256 performanceFeeBps;
    uint256 managementFeeBps;
    address recipient;
}
```

### ISuperVaultStrategy_SuperVaultState

```solidity
struct ISuperVaultStrategy_SuperVaultState {
    uint256 pendingRedeemRequest;
    uint256 claimableCancelRedeemRequest;
    uint256 maxWithdraw;
    uint256 averageRequestPPS;
    uint256 averageWithdrawPrice;
    uint16 redeemSlippageBps;
}
```

### ISuperVaultStrategy_YieldSource

```solidity
struct ISuperVaultStrategy_YieldSource {
    address oracle;
}
```

### ISuperVaultStrategy_YieldSourceInfo

```solidity
struct ISuperVaultStrategy_YieldSourceInfo {
    address sourceAddress;
    address oracle;
}
```

## Events

### DepositHandled

```solidity
event DepositHandled(address controller, uint256 assets, uint256 shares);
```

### EmergencyWithdrawableProposalCanceled

```solidity
event EmergencyWithdrawableProposalCanceled();
```

### EmergencyWithdrawableProposed

```solidity
event EmergencyWithdrawableProposed(bool newWithdrawable, uint256 effectiveTime);
```

### EmergencyWithdrawableUpdated

```solidity
event EmergencyWithdrawableUpdated(bool withdrawable);
```

### EmergencyWithdrawal

```solidity
event EmergencyWithdrawal(address recipient, uint256 assets);
```

### FeePaid

```solidity
event FeePaid(address recipient, uint256 amount, uint256 performanceFeeBps);
```

### FulfillHookExecuted

```solidity
event FulfillHookExecuted(address hook, address targetedYieldSource, bytes hookCalldata);
```

### HookExecuted

```solidity
event HookExecuted(address hook, address prevHook, address targetedYieldSource, bool usePrevHookAmount, bytes hookCalldata);
```

### HookRootProposed

```solidity
event HookRootProposed(bytes32 proposedRoot, uint256 effectiveTime);
```

### HookRootUpdated

```solidity
event HookRootUpdated(bytes32 newRoot);
```

### HooksExecuted

```solidity
event HooksExecuted(address[] hooks);
```

### Initialized

```solidity
event Initialized(uint64 version);
```

### Initialized

```solidity
event Initialized(address vault);
```

### ManagementFeePaid

```solidity
event ManagementFeePaid(address controller, address recipient, uint256 feeAssets, uint256 feeBps);
```

### MaxPPSSlippageUpdated

```solidity
event MaxPPSSlippageUpdated(uint256 maxSlippageBps);
```

### PPSUpdated

```solidity
event PPSUpdated(uint256 newPPS, uint256 calculationBlock);
```

### RedeemRequestCanceled

```solidity
event RedeemRequestCanceled(address controller, uint256 shares);
```

### RedeemRequestFulfilled

```solidity
event RedeemRequestFulfilled(address controller, address receiver, uint256 assets, uint256 shares);
```

### RedeemRequestPlaced

```solidity
event RedeemRequestPlaced(address controller, address owner, uint256 shares);
```

### RedeemRequestsFulfilled

```solidity
event RedeemRequestsFulfilled(address[] hooks, address[] controllers, uint256 processedShares, uint256 currentPPS);
```

### SuperGovernorSet

```solidity
event SuperGovernorSet(address superGovernor);
```

### VaultFeeConfigProposed

```solidity
event VaultFeeConfigProposed(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient, uint256 effectiveTime);
```

### VaultFeeConfigUpdated

```solidity
event VaultFeeConfigUpdated(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient);
```

### YieldSourceAdded

```solidity
event YieldSourceAdded(address source, address oracle);
```

### YieldSourceOracleUpdated

```solidity
event YieldSourceOracleUpdated(address source, address oldOracle, address newOracle);
```

### YieldSourceRemoved

```solidity
event YieldSourceRemoved(address source);
```

## Public/External Functions

### executeHooks(struct MockSuperVaultStrategy.ISuperVaultStrategy_ExecuteArgs)

- **Signature**: `executeHooks(struct MockSuperVaultStrategy.ISuperVaultStrategy_ExecuteArgs)`
- **Visibility**: public
- **Source Range**: 505:85:645
- **Details**: [function_executeHooks_struct_MockSuperVaultStrategy.ISuperVaultStrategy_ExecuteArgs.md](./function_executeHooks_struct_MockSuperVaultStrategy.ISuperVaultStrategy_ExecuteArgs.md)

**Signature:**
```solidity
function executeHooks(ISuperVaultStrategy_ExecuteArgs memory args) public payable;
```

### executeVaultFeeConfigUpdate()

- **Signature**: `executeVaultFeeConfigUpdate()`
- **Visibility**: public
- **Source Range**: 654:49:645
- **Details**: [function_executeVaultFeeConfigUpdate.md](./function_executeVaultFeeConfigUpdate.md)

**Signature:**
```solidity
function executeVaultFeeConfigUpdate() public;
```

### fulfillRedeemRequests(address[])

- **Signature**: `fulfillRedeemRequests(address[])`
- **Visibility**: public
- **Source Range**: 761:71:645
- **Details**: [function_fulfillRedeemRequests_address[].md](./function_fulfillRedeemRequests_address[].md)

**Signature:**
```solidity
function fulfillRedeemRequests(address[] memory controllers) public;
```

### handleOperations4626Mint(address,uint256,uint256,uint256)

- **Signature**: `handleOperations4626Mint(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 893:169:645
- **Details**: [function_handleOperations4626Mint_address_uint256_uint256_uint256.md](./function_handleOperations4626Mint_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function handleOperations4626Mint(address controller, uint256 sharesNet, uint256 assetsGross, uint256 assetsNet) public;
```

### handleOperations7540(uint8,address,address,uint256)

- **Signature**: `handleOperations7540(uint8,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1119:111:645
- **Details**: [function_handleOperations7540_uint8_address_address_uint256.md](./function_handleOperations7540_uint8_address_address_uint256.md)

**Signature:**
```solidity
function handleOperations7540(uint8 operation, address controller, address receiver, uint256 amount) public;
```

### initialize(address,struct MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig)

- **Signature**: `initialize(address,struct MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig)`
- **Visibility**: public
- **Source Range**: 1277:104:645
- **Details**: [function_initialize_address_struct_MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig.md](./function_initialize_address_struct_MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig.md)

**Signature:**
```solidity
function initialize(address vaultAddress, ISuperVaultStrategy_FeeConfig memory feeConfigData) public;
```

### manageYieldSource(address,address,uint8)

- **Signature**: `manageYieldSource(address,address,uint8)`
- **Visibility**: public
- **Source Range**: 1435:87:645
- **Details**: [function_manageYieldSource_address_address_uint8.md](./function_manageYieldSource_address_address_uint8.md)

**Signature:**
```solidity
function manageYieldSource(address source, address oracle, uint8 actionType) public;
```

### manageYieldSources(address[],address[],uint8[])

- **Signature**: `manageYieldSources(address[],address[],uint8[])`
- **Visibility**: public
- **Source Range**: 1577:126:645
- **Details**: [function_manageYieldSources_address[]_address[]_uint8[].md](./function_manageYieldSources_address[]_address[]_uint8[].md)

**Signature:**
```solidity
function manageYieldSources(address[] memory sources, address[] memory oracles, uint8[] memory actionTypes) public;
```

### moveAccumulatorOnTransfer(address,address,uint256)

- **Signature**: `moveAccumulatorOnTransfer(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1765:87:645
- **Details**: [function_moveAccumulatorOnTransfer_address_address_uint256.md](./function_moveAccumulatorOnTransfer_address_address_uint256.md)

**Signature:**
```solidity
function moveAccumulatorOnTransfer(address from, address to, uint256 shares) public;
```

### proposeVaultFeeConfigUpdate(uint256,uint256,address)

- **Signature**: `proposeVaultFeeConfigUpdate(uint256,uint256,address)`
- **Visibility**: public
- **Source Range**: 1916:157:645
- **Details**: [function_proposeVaultFeeConfigUpdate_uint256_uint256_address.md](./function_proposeVaultFeeConfigUpdate_uint256_uint256_address.md)

**Signature:**
```solidity
function proposeVaultFeeConfigUpdate(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient) public;
```

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 2126:30:645
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
receive() external payable;
```

### setPRECISIONReturn(uint256)

- **Signature**: `setPRECISIONReturn(uint256)`
- **Visibility**: public
- **Source Range**: 2573:97:645
- **Details**: [function_setPRECISIONReturn_uint256.md](./function_setPRECISIONReturn_uint256.md)

**Signature:**
```solidity
function setPRECISIONReturn(uint256 _value0) public;
```

### setClaimableWithdrawReturn(uint256)

- **Signature**: `setClaimableWithdrawReturn(uint256)`
- **Visibility**: public
- **Source Range**: 2735:113:645
- **Details**: [function_setClaimableWithdrawReturn_uint256.md](./function_setClaimableWithdrawReturn_uint256.md)

**Signature:**
```solidity
function setClaimableWithdrawReturn(uint256 _value0) public;
```

### setContainsYieldSourceReturn(bool)

- **Signature**: `setContainsYieldSourceReturn(bool)`
- **Visibility**: public
- **Source Range**: 2915:114:645
- **Details**: [function_setContainsYieldSourceReturn_bool.md](./function_setContainsYieldSourceReturn_bool.md)

**Signature:**
```solidity
function setContainsYieldSourceReturn(bool _value0) public;
```

### setEmergencyWithdrawableReturn(bool)

- **Signature**: `setEmergencyWithdrawableReturn(bool)`
- **Visibility**: public
- **Source Range**: 3098:118:645
- **Details**: [function_setEmergencyWithdrawableReturn_bool.md](./function_setEmergencyWithdrawableReturn_bool.md)

**Signature:**
```solidity
function setEmergencyWithdrawableReturn(bool _value0) public;
```

### setEmergencyWithdrawableEffectiveTimeReturn(uint256)

- **Signature**: `setEmergencyWithdrawableEffectiveTimeReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3298:147:645
- **Details**: [function_setEmergencyWithdrawableEffectiveTimeReturn_uint256.md](./function_setEmergencyWithdrawableEffectiveTimeReturn_uint256.md)

**Signature:**
```solidity
function setEmergencyWithdrawableEffectiveTimeReturn(uint256 _value0) public;
```

### setGetAverageWithdrawPriceReturn(uint256)

- **Signature**: `setGetAverageWithdrawPriceReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3516:125:645
- **Details**: [function_setGetAverageWithdrawPriceReturn_uint256.md](./function_setGetAverageWithdrawPriceReturn_uint256.md)

**Signature:**
```solidity
function setGetAverageWithdrawPriceReturn(uint256 _value0) public;
```

### setGetConfigInfoReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig)

- **Signature**: `setGetConfigInfoReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig)`
- **Visibility**: public
- **Source Range**: 3702:134:645
- **Details**: [function_setGetConfigInfoReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig.md](./function_setGetConfigInfoReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_FeeConfig.md)

**Signature:**
```solidity
function setGetConfigInfoReturn(ISuperVaultStrategy_FeeConfig memory _value0) public;
```

### setGetStoredPPSReturn(uint256)

- **Signature**: `setGetStoredPPSReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3896:103:645
- **Details**: [function_setGetStoredPPSReturn_uint256.md](./function_setGetStoredPPSReturn_uint256.md)

**Signature:**
```solidity
function setGetStoredPPSReturn(uint256 _value0) public;
```

### setGetSuperVaultStateReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_SuperVaultState)

- **Signature**: `setGetSuperVaultStateReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_SuperVaultState)`
- **Visibility**: public
- **Source Range**: 4065:150:645
- **Details**: [function_setGetSuperVaultStateReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_SuperVaultState.md](./function_setGetSuperVaultStateReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_SuperVaultState.md)

**Signature:**
```solidity
function setGetSuperVaultStateReturn(ISuperVaultStrategy_SuperVaultState memory _value0) public;
```

### setGetVaultInfoReturn(address,address,uint8)

- **Signature**: `setGetVaultInfoReturn(address,address,uint8)`
- **Visibility**: public
- **Source Range**: 4275:217:645
- **Details**: [function_setGetVaultInfoReturn_address_address_uint8.md](./function_setGetVaultInfoReturn_address_address_uint8.md)

**Signature:**
```solidity
function setGetVaultInfoReturn(address _value0, address _value1, uint8 _value2) public;
```

### setGetYieldSourceReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSource)

- **Signature**: `setGetYieldSourceReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSource)`
- **Visibility**: public
- **Source Range**: 4554:138:645
- **Details**: [function_setGetYieldSourceReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_YieldSource.md](./function_setGetYieldSourceReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_YieldSource.md)

**Signature:**
```solidity
function setGetYieldSourceReturn(ISuperVaultStrategy_YieldSource memory _value0) public;
```

### setGetYieldSourcesReturn(address[])

- **Signature**: `setGetYieldSourcesReturn(address[])`
- **Visibility**: public
- **Source Range**: 4755:235:645
- **Details**: [function_setGetYieldSourcesReturn_address[].md](./function_setGetYieldSourcesReturn_address[].md)

**Signature:**
```solidity
function setGetYieldSourcesReturn(address[] memory _value0) public;
```

### setGetYieldSourcesCountReturn(uint256)

- **Signature**: `setGetYieldSourcesCountReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5058:119:645
- **Details**: [function_setGetYieldSourcesCountReturn_uint256.md](./function_setGetYieldSourcesCountReturn_uint256.md)

**Signature:**
```solidity
function setGetYieldSourcesCountReturn(uint256 _value0) public;
```

### setGetYieldSourcesListReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[])

- **Signature**: `setGetYieldSourcesListReturn(struct MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[])`
- **Visibility**: public
- **Source Range**: 5244:275:645
- **Details**: [function_setGetYieldSourcesListReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[].md](./function_setGetYieldSourcesListReturn_struct_MockSuperVaultStrategy.ISuperVaultStrategy_YieldSourceInfo[].md)

**Signature:**
```solidity
function setGetYieldSourcesListReturn(ISuperVaultStrategy_YieldSourceInfo[] memory _value0) public;
```

### setHandleOperations4626DepositReturn(uint256)

- **Signature**: `setHandleOperations4626DepositReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5594:133:645
- **Details**: [function_setHandleOperations4626DepositReturn_uint256.md](./function_setHandleOperations4626DepositReturn_uint256.md)

**Signature:**
```solidity
function setHandleOperations4626DepositReturn(uint256 _value0) public;
```

### setPendingRedeemRequestReturn(uint256)

- **Signature**: `setPendingRedeemRequestReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5795:119:645
- **Details**: [function_setPendingRedeemRequestReturn_uint256.md](./function_setPendingRedeemRequestReturn_uint256.md)

**Signature:**
```solidity
function setPendingRedeemRequestReturn(uint256 _value0) public;
```

### setPreviewPerformanceFeeReturn(uint256,uint256,uint256)

- **Signature**: `setPreviewPerformanceFeeReturn(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5983:255:645
- **Details**: [function_setPreviewPerformanceFeeReturn_uint256_uint256_uint256.md](./function_setPreviewPerformanceFeeReturn_uint256_uint256_uint256.md)

**Signature:**
```solidity
function setPreviewPerformanceFeeReturn(uint256 _value0, uint256 _value1, uint256 _value2) public;
```

### setProposedEmergencyWithdrawableReturn(bool)

- **Signature**: `setProposedEmergencyWithdrawableReturn(bool)`
- **Visibility**: public
- **Source Range**: 6315:134:645
- **Details**: [function_setProposedEmergencyWithdrawableReturn_bool.md](./function_setProposedEmergencyWithdrawableReturn_bool.md)

**Signature:**
```solidity
function setProposedEmergencyWithdrawableReturn(bool _value0) public;
```

### setQuoteMintAssetsGrossReturn(uint256,uint256)

- **Signature**: `setQuoteMintAssetsGrossReturn(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 6517:185:645
- **Details**: [function_setQuoteMintAssetsGrossReturn_uint256_uint256.md](./function_setQuoteMintAssetsGrossReturn_uint256_uint256.md)

**Signature:**
```solidity
function setQuoteMintAssetsGrossReturn(uint256 _value0, uint256 _value1) public;
```

### setSuperGovernorReturn(address)

- **Signature**: `setSuperGovernorReturn(address)`
- **Visibility**: public
- **Source Range**: 6763:105:645
- **Details**: [function_setSuperGovernorReturn_address.md](./function_setSuperGovernorReturn_address.md)

**Signature:**
```solidity
function setSuperGovernorReturn(address _value0) public;
```

### PRECISION()

- **Signature**: `PRECISION()`
- **Visibility**: public
- **Source Range**: 13191:93:645
- **Details**: [function_PRECISION.md](./function_PRECISION.md)

**Signature:**
```solidity
function PRECISION() public view returns (uint256);
```

### claimableWithdraw(address)

- **Signature**: `claimableWithdraw(address)`
- **Visibility**: public
- **Source Range**: 13338:173:645
- **Details**: [function_claimableWithdraw_address.md](./function_claimableWithdraw_address.md)

**Signature:**
```solidity
function claimableWithdraw(address) public view returns (uint256);
```

### containsYieldSource(address)

- **Signature**: `containsYieldSource(address)`
- **Visibility**: public
- **Source Range**: 13567:170:645
- **Details**: [function_containsYieldSource_address.md](./function_containsYieldSource_address.md)

**Signature:**
```solidity
function containsYieldSource(address) public view returns (bool);
```

### emergencyWithdrawable()

- **Signature**: `emergencyWithdrawable()`
- **Visibility**: public
- **Source Range**: 13795:114:645
- **Details**: [function_emergencyWithdrawable.md](./function_emergencyWithdrawable.md)

**Signature:**
```solidity
function emergencyWithdrawable() public view returns (bool);
```

### emergencyWithdrawableEffectiveTime()

- **Signature**: `emergencyWithdrawableEffectiveTime()`
- **Visibility**: public
- **Source Range**: 13980:143:645
- **Details**: [function_emergencyWithdrawableEffectiveTime.md](./function_emergencyWithdrawableEffectiveTime.md)

**Signature:**
```solidity
function emergencyWithdrawableEffectiveTime() public view returns (uint256);
```

### getAverageWithdrawPrice(address)

- **Signature**: `getAverageWithdrawPrice(address)`
- **Visibility**: public
- **Source Range**: 14183:185:645
- **Details**: [function_getAverageWithdrawPrice_address.md](./function_getAverageWithdrawPrice_address.md)

**Signature:**
```solidity
function getAverageWithdrawPrice(address) public view returns (uint256);
```

### getConfigInfo()

- **Signature**: `getConfigInfo()`
- **Visibility**: public
- **Source Range**: 14418:130:645
- **Details**: [function_getConfigInfo.md](./function_getConfigInfo.md)

**Signature:**
```solidity
function getConfigInfo() public view returns (ISuperVaultStrategy_FeeConfig memory);
```

### getStoredPPS()

- **Signature**: `getStoredPPS()`
- **Visibility**: public
- **Source Range**: 14597:99:645
- **Details**: [function_getStoredPPS.md](./function_getStoredPPS.md)

**Signature:**
```solidity
function getStoredPPS() public view returns (uint256);
```

### getSuperVaultState(address)

- **Signature**: `getSuperVaultState(address)`
- **Visibility**: public
- **Source Range**: 14751:210:645
- **Details**: [function_getSuperVaultState_address.md](./function_getSuperVaultState_address.md)

**Signature:**
```solidity
function getSuperVaultState(address) public view returns (ISuperVaultStrategy_SuperVaultState memory);
```

### getVaultInfo()

- **Signature**: `getVaultInfo()`
- **Visibility**: public
- **Source Range**: 15010:163:645
- **Details**: [function_getVaultInfo.md](./function_getVaultInfo.md)

**Signature:**
```solidity
function getVaultInfo() public view returns (address, address, uint8);
```

### getYieldSource(address)

- **Signature**: `getYieldSource(address)`
- **Visibility**: public
- **Source Range**: 15224:194:645
- **Details**: [function_getYieldSource_address.md](./function_getYieldSource_address.md)

**Signature:**
```solidity
function getYieldSource(address) public view returns (ISuperVaultStrategy_YieldSource memory);
```

### getYieldSources()

- **Signature**: `getYieldSources()`
- **Visibility**: public
- **Source Range**: 15470:114:645
- **Details**: [function_getYieldSources.md](./function_getYieldSources.md)

**Signature:**
```solidity
function getYieldSources() public view returns (address[] memory);
```

### getYieldSourcesCount()

- **Signature**: `getYieldSourcesCount()`
- **Visibility**: public
- **Source Range**: 15641:115:645
- **Details**: [function_getYieldSourcesCount.md](./function_getYieldSourcesCount.md)

**Signature:**
```solidity
function getYieldSourcesCount() public view returns (uint256);
```

### getYieldSourcesList()

- **Signature**: `getYieldSourcesList()`
- **Visibility**: public
- **Source Range**: 15812:150:645
- **Details**: [function_getYieldSourcesList.md](./function_getYieldSourcesList.md)

**Signature:**
```solidity
function getYieldSourcesList() public view returns (ISuperVaultStrategy_YieldSourceInfo[] memory);
```

### handleOperations4626Deposit(address,uint256)

- **Signature**: `handleOperations4626Deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 16026:234:645
- **Details**: [function_handleOperations4626Deposit_address_uint256.md](./function_handleOperations4626Deposit_address_uint256.md)

**Signature:**
```solidity
function handleOperations4626Deposit(address, uint256) public view returns (uint256);
```

### pendingRedeemRequest(address)

- **Signature**: `pendingRedeemRequest(address)`
- **Visibility**: public
- **Source Range**: 16317:179:645
- **Details**: [function_pendingRedeemRequest_address.md](./function_pendingRedeemRequest_address.md)

**Signature:**
```solidity
function pendingRedeemRequest(address) public view returns (uint256);
```

### previewPerformanceFee(address,uint256)

- **Signature**: `previewPerformanceFee(address,uint256)`
- **Visibility**: public
- **Source Range**: 16554:309:645
- **Details**: [function_previewPerformanceFee_address_uint256.md](./function_previewPerformanceFee_address_uint256.md)

**Signature:**
```solidity
function previewPerformanceFee(address, uint256) public view returns (uint256, uint256, uint256);
```

### proposedEmergencyWithdrawable()

- **Signature**: `proposedEmergencyWithdrawable()`
- **Visibility**: public
- **Source Range**: 16929:130:645
- **Details**: [function_proposedEmergencyWithdrawable.md](./function_proposedEmergencyWithdrawable.md)

**Signature:**
```solidity
function proposedEmergencyWithdrawable() public view returns (bool);
```

### quoteMintAssetsGross(uint256)

- **Signature**: `quoteMintAssetsGross(uint256)`
- **Visibility**: public
- **Source Range**: 17116:217:645
- **Details**: [function_quoteMintAssetsGross_uint256.md](./function_quoteMintAssetsGross_uint256.md)

**Signature:**
```solidity
function quoteMintAssetsGross(uint256) public view returns (uint256, uint256);
```

### superGovernor()

- **Signature**: `superGovernor()`
- **Visibility**: public
- **Source Range**: 17383:101:645
- **Details**: [function_superGovernor.md](./function_superGovernor.md)

**Signature:**
```solidity
function superGovernor() public view returns (address);
```
