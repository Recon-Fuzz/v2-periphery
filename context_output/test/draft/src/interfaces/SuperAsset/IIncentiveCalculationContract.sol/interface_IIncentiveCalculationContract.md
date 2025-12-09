# Interface: IIncentiveCalculationContract

## Metadata

- **Name**: IIncentiveCalculationContract
- **Type**: Interface
- **Path**: test/draft/src/interfaces/SuperAsset/IIncentiveCalculationContract.sol
- **Documentation**: @title IIncentiveCalculationContract
   @author Superform Labs
   @notice Interface for IncentiveCalculationContract which handles the energy function and incentive calculations

## Errors

### INVALID_ARRAY_LENGTH

```solidity
/// @notice Thrown when input arrays have different lengths
error INVALID_ARRAY_LENGTH();
```

## Events

### EnergyCalculationFailed

```solidity
event EnergyCalculationFailed();
```

## Public/External Functions

### energy(uint256[],uint256[],uint256[],uint256,uint256)

- **Signature**: `energy(uint256[],uint256[],uint256[],uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1471:298:557

**Signature:**
```solidity
/// @notice Calculates the energy function.
///  @param currentAllocation The current allocation.
///  @param allocationTarget The target allocation.
///  @param weights The weights for each allocation in the energy calculation.
///  @param totalCurrentAllocation The total current allocation.
///  @param totalAllocationTarget The total target allocation.
///  @return res The calculated energy value.
///  @return isSuccess A boolean indicating whether the calculation was successful.
function energy(uint256[] memory currentAllocation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalCurrentAllocation, uint256 totalAllocationTarget) external pure returns (uint256 res, bool isSuccess);;
```

### calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)

- **Signature**: `calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2617:466:557

**Signature:**
```solidity
/// @notice Calculates the incentive.
///  @param allocationPreOperation The allocation before the operation.
///  @param allocationPostOperation The allocation after the operation.
///  @param allocationTarget The target allocation.
///  @param weights The weights for each allocation in the energy calculation.
///  @param totalAllocationPreOperation The total allocation before the operation.
///  @param totalAllocationPostOperation The total allocation after the operation.
///  @param totalAllocationTarget The total target allocation.
///  @param energyToUSDExchangeRatio The ratio to convert energy units to USD (scaled by PRECISION).
///  @return incentiveUSD The calculated incentive in USD (scaled by PRECISION).
///  @return isSuccess A boolean indicating whether the calculation was successful.
function calculateIncentive(uint256[] memory allocationPreOperation, uint256[] memory allocationPostOperation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalAllocationPreOperation, uint256 totalAllocationPostOperation, uint256 totalAllocationTarget, uint256 energyToUSDExchangeRatio) external view returns (int256 incentiveUSD, bool isSuccess);;
```
