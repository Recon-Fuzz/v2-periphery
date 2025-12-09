# Contract: SuperAssetFactory

## Metadata

- **Name**: SuperAssetFactory
- **Type**: Contract
- **Path**: test/draft/src/SuperAsset/SuperAssetFactory.sol
- **Documentation**:  @title SuperAssetFactory
   @author Superform Labs
   @notice Factory contract that deploys SuperAsset and its dependencies

## Implements Interfaces

- **ISuperAssetFactory** [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variables

### superAssetImplementation

```solidity
address public immutable superAssetImplementation
```

### incentiveFundImplementation

```solidity
address public immutable incentiveFundImplementation
```

### superGovernor

```solidity
address public immutable superGovernor
```

### superRegistry

```solidity
address public immutable superRegistry
```

### data

```solidity
mapping(address => SuperAssetData) public data
```

### incentiveCalculationContractsWhitelist

```solidity
mapping(address => bool) public incentiveCalculationContractsWhitelist
```

## Structs

### AssetCreationParams (inherited from ISuperAssetFactory)

```solidity
/// @notice Parameters required for creating a new SuperAsset
///  @param name Name of the SuperAsset token
///  @param symbol Symbol of the SuperAsset token
///  @param swapFeeInPercentage Initial swap fee percentage for deposits
///  @param swapFeeOutPercentage Initial swap fee percentage for redemptions
///  @param asset Address of the primary asset
///  @param superAssetManager Address of the manager
///  @param superAssetStrategist Address of the strategist
///  @param incentiveFundManager Address of the incentive fund manager
///  @param incentiveCalculationContract Address of the incentive calculation contract
///  @param tokenInIncentive Address of the token for incoming incentives
///  @param tokenOutIncentive Address of the token for outgoing incentives
struct AssetCreationParams {
    string name;
    string symbol;
    uint256 swapFeeInPercentage;
    uint256 swapFeeOutPercentage;
    address asset;
    address superAssetManager;
    address superAssetStrategist;
    address incentiveFundManager;
    address incentiveCalculationContract;
    address tokenInIncentive;
    address tokenOutIncentive;
}
```

### SuperAssetData (inherited from ISuperAssetFactory)

```solidity
/// @notice Data for a SuperAsset
///  @param superAssetStrategist Address of the strategist
///  @param superAssetManager Address of the manager
///  @param incentiveFundManager Address of the incentive fund manager
///  @param incentiveCalculationContract Address of the incentive calculation contract
///  @param incentiveFundContract Address of the incentive fund contract
struct SuperAssetData {
    address superAssetStrategist;
    address superAssetManager;
    address incentiveFundManager;
    address incentiveCalculationContract;
    address incentiveFundContract;
}
```

## Errors

### ZERO_ADDRESS (inherited from ISuperAssetFactory)

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### UNAUTHORIZED (inherited from ISuperAssetFactory)

```solidity
/// @notice Thrown when the caller is not authorized
error UNAUTHORIZED();
```

### ICC_NOT_WHITELISTED (inherited from ISuperAssetFactory)

```solidity
/// @notice Thrown when ICC is not whitelisted
error ICC_NOT_WHITELISTED();
```

## Events

### SuperAssetCreated (inherited from ISuperAssetFactory)

```solidity
/// @notice Emitted when a new SuperAsset and its dependencies are created
///  @param superAsset Address of the deployed SuperAsset contract
///  @param incentiveFund Address of the deployed IncentiveFundContract
///  @param incentiveCalc Address of the deployed IncentiveCalculationContract
///  @param name Name of the SuperAsset token
///  @param symbol Symbol of the SuperAsset token
event SuperAssetCreated(address indexed superAsset, address indexed incentiveFund, address incentiveCalc, string name, string symbol);
```

## Public/External Functions

### constructor(address,address)

- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1440:383:549
- **Details**: [function_constructor_address_address.md](./function_constructor_address_address.md)

**Signature:**
```solidity
constructor(address _superGovernor, address _superRegistry);
```

### addICCToWhitelist(address)

- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 1868:180:549
- **Details**: [function_addICCToWhitelist_address.md](./function_addICCToWhitelist_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function addICCToWhitelist(address icc) external;
```

### removeICCFromWhitelist(address)

- **Signature**: `removeICCFromWhitelist(address)`
- **Visibility**: external
- **Source Range**: 2093:186:549
- **Details**: [function_removeICCFromWhitelist_address.md](./function_removeICCFromWhitelist_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function removeICCFromWhitelist(address icc) external;
```

### isICCWhitelisted(address)

- **Signature**: `isICCWhitelisted(address)`
- **Visibility**: external
- **Source Range**: 2324:135:549
- **Details**: [function_isICCWhitelisted_address.md](./function_isICCWhitelisted_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function isICCWhitelisted(address icc) external view returns (bool);
```

### setSuperAssetManager(address,address)

- **Signature**: `setSuperAssetManager(address,address)`
- **Visibility**: external
- **Source Range**: 2504:418:549
- **Details**: [function_setSuperAssetManager_address_address.md](./function_setSuperAssetManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function setSuperAssetManager(address superAsset, address _superAssetManager) external;
```

### setSuperAssetStrategist(address,address)

- **Signature**: `setSuperAssetStrategist(address,address)`
- **Visibility**: external
- **Source Range**: 2967:328:549
- **Details**: [function_setSuperAssetStrategist_address_address.md](./function_setSuperAssetStrategist_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function setSuperAssetStrategist(address superAsset, address _superAssetStrategist) external;
```

### setIncentiveFundManager(address,address)

- **Signature**: `setIncentiveFundManager(address,address)`
- **Visibility**: external
- **Source Range**: 3340:328:549
- **Details**: [function_setIncentiveFundManager_address_address.md](./function_setIncentiveFundManager_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function setIncentiveFundManager(address superAsset, address _incentiveFundManager) external;
```

### setIncentiveCalculationContract(address,address)

- **Signature**: `setIncentiveCalculationContract(address,address)`
- **Visibility**: external
- **Source Range**: 3713:482:549
- **Details**: [function_setIncentiveCalculationContract_address_address.md](./function_setIncentiveCalculationContract_address_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function setIncentiveCalculationContract(address superAsset, address _incentiveCalculationContract) external;
```

### getSuperAssetManager(address)

- **Signature**: `getSuperAssetManager(address)`
- **Visibility**: external
- **Source Range**: 4240:140:549
- **Details**: [function_getSuperAssetManager_address.md](./function_getSuperAssetManager_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function getSuperAssetManager(address superAsset) external view returns (address);
```

### getSuperAssetStrategist(address)

- **Signature**: `getSuperAssetStrategist(address)`
- **Visibility**: external
- **Source Range**: 4425:146:549
- **Details**: [function_getSuperAssetStrategist_address.md](./function_getSuperAssetStrategist_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function getSuperAssetStrategist(address superAsset) external view returns (address);
```

### getIncentiveFundManager(address)

- **Signature**: `getIncentiveFundManager(address)`
- **Visibility**: external
- **Source Range**: 4616:146:549
- **Details**: [function_getIncentiveFundManager_address.md](./function_getIncentiveFundManager_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveFundManager(address superAsset) external view returns (address);
```

### getIncentiveCalculationContract(address)

- **Signature**: `getIncentiveCalculationContract(address)`
- **Visibility**: external
- **Source Range**: 4807:162:549
- **Details**: [function_getIncentiveCalculationContract_address.md](./function_getIncentiveCalculationContract_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveCalculationContract(address superAsset) external view returns (address);
```

### getIncentiveFundContract(address)

- **Signature**: `getIncentiveFundContract(address)`
- **Visibility**: external
- **Source Range**: 5014:148:549
- **Details**: [function_getIncentiveFundContract_address.md](./function_getIncentiveFundContract_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function getIncentiveFundContract(address superAsset) external view returns (address);
```

### createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)

- **Signature**: `createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)`
- **Visibility**: external
- **Source Range**: 5392:1753:549
- **Details**: [function_createSuperAsset_struct_ISuperAssetFactory.AssetCreationParams.md](./function_createSuperAsset_struct_ISuperAssetFactory.AssetCreationParams.md)

**Signature:**
```solidity
/// @inheritdoc ISuperAssetFactory
function createSuperAsset(AssetCreationParams calldata params) external returns (address superAsset, address incentiveFundContract);
```
