# Interface: ISuperHookLoans

## Metadata

- **Name**: ISuperHookLoans
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookLoans
   @author Superform Labs
   @notice Interface for hooks that interact with lending protocols
   @dev Extends context awareness to enable loan operations within hook chains

## Implements Interfaces

- **ISuperHookContextAware** [lib/v2-core/src/interfaces/ISuperHook.sol/interface_ISuperHookContextAware.md]

## Public/External Functions

### getLoanTokenAddress(bytes)

- **Signature**: `getLoanTokenAddress(bytes)`
- **Visibility**: external
- **Source Range**: 7041:80:422

**Signature:**
```solidity
/// @notice Gets the address of the token being borrowed
///  @dev Used to identify which asset is being borrowed from the lending protocol
///  @param data The hook-specific data containing loan information
///  @return The address of the borrowed token
function getLoanTokenAddress(bytes memory data) external pure returns (address);;
```

### getCollateralTokenAddress(bytes)

- **Signature**: `getCollateralTokenAddress(bytes)`
- **Visibility**: external
- **Source Range**: 7396:86:422

**Signature:**
```solidity
/// @notice Gets the address of the token used as collateral
///  @dev Used to identify which asset is being used to secure the loan
///  @param data The hook-specific data containing collateral information
///  @return The address of the collateral token
function getCollateralTokenAddress(bytes memory data) external view returns (address);;
```

### getLoanTokenBalance(address,bytes)

- **Signature**: `getLoanTokenBalance(address,bytes)`
- **Visibility**: external
- **Source Range**: 7798:97:422

**Signature:**
```solidity
/// @notice Gets the current loan token balance for an account
///  @dev Used to track outstanding loan amounts
///  @param account The account to check the loan balance for
///  @param data The hook-specific data containing loan parameters
///  @return The amount of tokens currently borrowed
function getLoanTokenBalance(address account, bytes memory data) external view returns (uint256);;
```

### getCollateralTokenBalance(address,bytes)

- **Signature**: `getCollateralTokenBalance(address,bytes)`
- **Visibility**: external
- **Source Range**: 8235:103:422

**Signature:**
```solidity
/// @notice Gets the current collateral token balance for an account
///  @dev Used to track collateral positions
///  @param account The account to check the collateral balance for
///  @param data The hook-specific data containing collateral parameters
///  @return The amount of tokens currently used as collateral
function getCollateralTokenBalance(address account, bytes memory data) external view returns (uint256);;
```

### decodeUsePrevHookAmount(bytes) (inherited from ISuperHookContextAware)

- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 4733:81:422

**Signature:**
```solidity
/// @notice Determines if this hook should use the amount from the previous hook
///  @dev Used to create hook chains where output from one hook becomes input to the next
///  @param data The hook-specific data containing configuration
///  @return True if the hook should use the previous hook's output amount
function decodeUsePrevHookAmount(bytes memory data) external pure returns (bool);;
```
