# Interface: INexusAccountFactory

## Metadata

- **Name**: INexusAccountFactory
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/nexus/interfaces/INexusAccountFactory.sol

## Public/External Functions

### createAccount(bytes,bytes32)

- **Signature**: `createAccount(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 397:151:171

**Signature:**
```solidity
/// @notice Creates a new Nexus account with the provided initialization data.
///  @param initData Initialization data to be called on the new Smart Account.
///  @param salt Unique salt for the Smart Account creation.
///  @return The address of the newly created Nexus account.
function createAccount(bytes calldata initData, bytes32 salt) external payable returns (address payable);;
```

### computeAccountAddress(bytes,bytes32)

- **Signature**: `computeAccountAddress(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 974:172:171

**Signature:**
```solidity
/// @notice Computes the expected address of a Nexus contract using the factory's deterministic
///  deployment algorithm.
///  @param initData Initialization data to be called on the new Smart Account.
///  @param salt Unique salt for the Smart Account creation.
///  @return expectedAddress The expected address at which the Nexus contract will be deployed if
///  the provided parameters are used.
function computeAccountAddress(bytes calldata initData, bytes32 salt) external view returns (address payable expectedAddress);;
```
