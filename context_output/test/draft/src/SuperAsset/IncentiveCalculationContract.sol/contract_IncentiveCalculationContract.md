# Contract: IncentiveCalculationContract

## Metadata

- **Name**: IncentiveCalculationContract
- **Type**: Contract
- **Path**: test/draft/src/SuperAsset/IncentiveCalculationContract.sol
- **Documentation**: @title IncentiveCalculationContract
   @author Superform Labs
   @notice A stateless contract for calculating incentives.

## Implements Interfaces

- **IIncentiveCalculationContract** [test/draft/src/interfaces/SuperAsset/IIncentiveCalculationContract.sol/interface_IIncentiveCalculationContract.md]

## State Variables

### PRECISION

```solidity
uint256 public constant PRECISION = 1e18
```

### PERC

```solidity
uint256 public constant PERC = 100e18
```

## Errors

### INVALID_ARRAY_LENGTH (inherited from IIncentiveCalculationContract)

```solidity
/// @notice Thrown when input arrays have different lengths
error INVALID_ARRAY_LENGTH();
```

## Events

### EnergyCalculationFailed (inherited from IIncentiveCalculationContract)

```solidity
event EnergyCalculationFailed();
```

## Public/External Functions

### energy(uint256[],uint256[],uint256[],uint256,uint256)

- **Signature**: `energy(uint256[],uint256[],uint256[],uint256,uint256)`
- **Visibility**: public
- **Source Range**: 668:1548:546
- **Details**: [function_energy_uint256[]_uint256[]_uint256[]_uint256_uint256.md](./function_energy_uint256[]_uint256[]_uint256[]_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveCalculationContract
function energy(uint256[] memory currentAllocation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalCurrentAllocation, uint256 totalAllocationTarget) public pure returns (uint256 res, bool isSuccess);
```

### calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)

- **Signature**: `calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2272:1780:546
- **Details**: [function_calculateIncentive_uint256[]_uint256[]_uint256[]_uint256[]_uint256_uint256_uint256_uint256.md](./function_calculateIncentive_uint256[]_uint256[]_uint256[]_uint256[]_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IIncentiveCalculationContract
function calculateIncentive(uint256[] memory allocationPreOperation, uint256[] memory allocationPostOperation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalAllocationPreOperation, uint256 totalAllocationPostOperation, uint256 totalAllocationTarget, uint256 energyToUSDExchangeRatio) public pure returns (int256 incentiveUSD, bool isSuccess);
```
