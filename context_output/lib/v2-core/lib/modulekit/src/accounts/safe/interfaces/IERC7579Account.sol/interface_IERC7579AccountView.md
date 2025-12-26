# Interface: IERC7579AccountView

## Metadata

- **Name**: IERC7579AccountView
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/IERC7579Account.sol

## Public/External Functions

### accountId()

- **Signature**: `accountId()`
- **Visibility**: external
- **Source Range**: 694:83:175

**Signature:**
```solidity
///  @dev Returns the account id of the smart account
///  @return accountImplementationId the account id of the smart account
///  the accountId should be structured like so:
///         "vendorname.accountname.semver"
function accountId() external view returns (string memory accountImplementationId);;
```

### supportsExecutionMode(ModeCode)

- **Signature**: `supportsExecutionMode(ModeCode)`
- **Visibility**: external
- **Source Range**: 940:82:175

**Signature:**
```solidity
///  Function to check if the account supports a certain CallType or ExecType (see ModeLib.sol)
///  @param encodedMode the encoded mode
function supportsExecutionMode(ModeCode encodedMode) external view returns (bool);;
```

### supportsModule(uint256)

- **Signature**: `supportsModule(uint256)`
- **Visibility**: external
- **Source Range**: 1208:75:175

**Signature:**
```solidity
///  Function to check if the account supports installation of a certain module type Id
///  @param moduleTypeId the module type ID according the ERC-7579 spec
function supportsModule(uint256 moduleTypeId) external view returns (bool);;
```
