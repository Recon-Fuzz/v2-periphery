# Interface: ISuperAssetFactory

## Metadata

- **Name**: ISuperAssetFactory
- **Type**: Interface
- **Path**: test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol
- **Documentation**:  @title ISuperAssetFactory
   @notice Interface for the SuperAssetFactory contract which deploys SuperAsset and its dependencies

## Structs

### AssetCreationParams

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

### SuperAssetData

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

### ZERO_ADDRESS

```solidity
/// @notice Thrown when an address parameter is zero
error ZERO_ADDRESS();
```

### UNAUTHORIZED

```solidity
/// @notice Thrown when the caller is not authorized
error UNAUTHORIZED();
```

### ICC_NOT_WHITELISTED

```solidity
/// @notice Thrown when ICC is not whitelisted
error ICC_NOT_WHITELISTED();
```

## Events

### SuperAssetCreated

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

### setSuperAssetManager(address,address)

- **Signature**: `setSuperAssetManager(address,address)`
- **Visibility**: external
- **Source Range**: 3772:87:560

**Signature:**
```solidity
/// @notice Sets the manager for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @param _superAssetManager Address of the manager
function setSuperAssetManager(address superAsset, address _superAssetManager) external;;
```

### setSuperAssetStrategist(address,address)

- **Signature**: `setSuperAssetStrategist(address,address)`
- **Visibility**: external
- **Source Range**: 4042:93:560

**Signature:**
```solidity
/// @notice Sets the strategist for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @param _superAssetStrategist Address of the strategist
function setSuperAssetStrategist(address superAsset, address _superAssetStrategist) external;;
```

### setIncentiveFundManager(address,address)

- **Signature**: `setIncentiveFundManager(address,address)`
- **Visibility**: external
- **Source Range**: 4342:93:560

**Signature:**
```solidity
/// @notice Sets the incentive fund manager for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @param _incentiveFundManager Address of the incentive fund manager
function setIncentiveFundManager(address superAsset, address _incentiveFundManager) external;;
```

### setIncentiveCalculationContract(address,address)

- **Signature**: `setIncentiveCalculationContract(address,address)`
- **Visibility**: external
- **Source Range**: 4665:108:560

**Signature:**
```solidity
/// @notice Sets the incentive calculation contract for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @param incentiveCalculationContract Address of the incentive calculation contract
function setIncentiveCalculationContract(address superAsset, address incentiveCalculationContract) external;;
```

### getSuperAssetManager(address)

- **Signature**: `getSuperAssetManager(address)`
- **Visibility**: external
- **Source Range**: 4947:82:560

**Signature:**
```solidity
/// @notice Gets the manager for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @return superAssetManager Address of the manager
function getSuperAssetManager(address superAsset) external view returns (address);;
```

### getSuperAssetStrategist(address)

- **Signature**: `getSuperAssetStrategist(address)`
- **Visibility**: external
- **Source Range**: 5212:85:560

**Signature:**
```solidity
/// @notice Gets the strategist for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @return superAssetStrategist Address of the strategist
function getSuperAssetStrategist(address superAsset) external view returns (address);;
```

### getIncentiveFundManager(address)

- **Signature**: `getIncentiveFundManager(address)`
- **Visibility**: external
- **Source Range**: 5504:85:560

**Signature:**
```solidity
/// @notice Gets the incentive fund manager for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @return incentiveFundManager Address of the incentive fund manager
function getIncentiveFundManager(address superAsset) external view returns (address);;
```

### getIncentiveCalculationContract(address)

- **Signature**: `getIncentiveCalculationContract(address)`
- **Visibility**: external
- **Source Range**: 5820:93:560

**Signature:**
```solidity
/// @notice Gets the incentive calculation contract for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @return incentiveCalculationContract Address of the incentive calculation contract
function getIncentiveCalculationContract(address superAsset) external view returns (address);;
```

### getIncentiveFundContract(address)

- **Signature**: `getIncentiveFundContract(address)`
- **Visibility**: external
- **Source Range**: 6123:86:560

**Signature:**
```solidity
/// @notice Gets the incentive fund contract for a SuperAsset
///  @param superAsset Address of the SuperAsset contract
///  @return incentiveFundContract Address of the incentive fund contract
function getIncentiveFundContract(address superAsset) external view returns (address);;
```

### addICCToWhitelist(address)

- **Signature**: `addICCToWhitelist(address)`
- **Visibility**: external
- **Source Range**: 6352:49:560

**Signature:**
```solidity
/// @notice Adds an Incentive Calculation Contract to the whitelist
///  @param icc Address of the Incentive Calculation Contract
function addICCToWhitelist(address icc) external;;
```

### removeICCFromWhitelist(address)

- **Signature**: `removeICCFromWhitelist(address)`
- **Visibility**: external
- **Source Range**: 6549:54:560

**Signature:**
```solidity
/// @notice Removes an Incentive Calculation Contract from the whitelist
///  @param icc Address of the Incentive Calculation Contract
function removeICCFromWhitelist(address icc) external;;
```

### isICCWhitelisted(address)

- **Signature**: `isICCWhitelisted(address)`
- **Visibility**: external
- **Source Range**: 6831:68:560

**Signature:**
```solidity
/// @notice Checks if an Incentive Calculation Contract is whitelisted
///  @param icc Address of the Incentive Calculation Contract
///  @return isValid Whether the Incentive Calculation Contract is whitelisted
function isICCWhitelisted(address icc) external view returns (bool);;
```

### createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)

- **Signature**: `createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)`
- **Visibility**: external
- **Source Range**: 7185:140:560

**Signature:**
```solidity
/// @notice Creates a new SuperAsset instance with its dependencies
///  @param params Parameters for creating the SuperAsset
///  @return superAsset Address of the deployed SuperAsset contract
///  @return incentiveFund Address of the deployed IncentiveFundContract
function createSuperAsset(AssetCreationParams calldata params) external returns (address superAsset, address incentiveFund);;
```
