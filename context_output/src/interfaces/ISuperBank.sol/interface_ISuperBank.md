# Interface: ISuperBank

## Metadata

- **Name**: ISuperBank
- **Type**: Interface
- **Path**: src/interfaces/ISuperBank.sol
- **Documentation**: @title ISuperBank
   @author Superform Labs
   @notice Interface for SuperBank, which compounds protocol revenue into sUP by executing registered hooks.

## Implements Interfaces

- **IHookExecutionData** [src/interfaces/IHookExecutionData.sol/interface_IHookExecutionData.md]

## Structs

### HookExecutionData (inherited from IHookExecutionData)

```solidity
/// @notice Data required for executing hooks with Merkle proof verification.
///  @param hooks Array of addresses of hooks to execute.
///  @param data Array of arbitrary data to pass to each hook.
///  @param merkleProofs Double array of Merkle proofs verifying each hook's allowed targets.
///  @param expectedAssetsOrSharesOut Array of minimum expected output amounts for slippage protection.
struct HookExecutionData {
    address[] hooks;
    bytes[] data;
    bytes32[][] merkleProofs;
    uint256[] expectedAssetsOrSharesOut;
}
```

## Errors

### INVALID_ADDRESS

```solidity
/// @notice Error thrown when an invalid address is provided.
error INVALID_ADDRESS();
```

### TRANSFER_FAILED

```solidity
/// @notice Error thrown when a transfer fails.
error TRANSFER_FAILED();
```

### INVALID_UP_AMOUNT_TO_DISTRIBUTE

```solidity
/// @notice Error thrown when an invalid UP amount is provided.
error INVALID_UP_AMOUNT_TO_DISTRIBUTE();
```

### INVALID_BANK_MANAGER

```solidity
/// @notice Error thrown when an invalid bank manager is provided.
error INVALID_BANK_MANAGER();
```

### INVALID_REVENUE_SHARE

```solidity
/// @notice Error thrown when revenue share exceeds maximum allowed (BPS_PRECISION).
error INVALID_REVENUE_SHARE();
```

## Events

### RevenueDistributed

```solidity
/// @notice Emitted when revenue is distributed to sUP and Treasury.
///  @param upToken The address of the UP token.
///  @param supStrategyVault The address of the sUP strategy.
///  @param treasury The address of the Treasury.
///  @param supAmount The amount sent to sUP.
///  @param treasuryAmount The amount sent to Treasury.
event RevenueDistributed(address indexed upToken, address indexed supStrategyVault, address indexed treasury, uint256 supAmount, uint256 treasuryAmount);
```

## Public/External Functions

### executeHooks(struct IHookExecutionData.HookExecutionData)

- **Signature**: `executeHooks(struct IHookExecutionData.HookExecutionData)`
- **Visibility**: external
- **Source Range**: 2300:81:517

**Signature:**
```solidity
/// @notice Executes a batch of hooks, verifying each with a Merkle proof.
///  @dev Each hook is verified against a Merkle root from SuperGovernor.
///  @dev Hooks must implement the ISuperHook interface (preExecute, build, postExecute).
///  @param executionData HookExecutionData struct containing arrays of hooks, data, and Merkle proofs.
function executeHooks(HookExecutionData calldata executionData) external payable;;
```

### distribute(uint256)

- **Signature**: `distribute(uint256)`
- **Visibility**: external
- **Source Range**: 2634:47:517

**Signature:**
```solidity
/// @notice Distributes UP tokens based on governance-agreed revenue share.
///  @dev Transfers X% (REVENUE_SHARE) of UP tokens to sUP, and the remainder to Superform Treasury.
///  @param upAmount The amount of UP tokens to distribute.
function distribute(uint256 upAmount) external;;
```
