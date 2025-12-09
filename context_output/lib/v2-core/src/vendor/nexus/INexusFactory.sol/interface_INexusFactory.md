# Interface: INexusFactory

## Metadata

- **Name**: INexusFactory
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/nexus/INexusFactory.sol

## Public/External Functions

### createAccount(bytes,bytes32)

- **Signature**: `createAccount(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 359:105:462

**Signature:**
```solidity
/// @notice Creates a new Nexus with initialization data.
///  @param initData Initialization data to be called on the new Smart Account.
///  @param salt Unique salt for the Smart Account creation.
///  @return The address of the newly created Nexus.
function createAccount(bytes calldata initData, bytes32 salt) external payable returns (address payable);;
```

### computeAccountAddress(bytes,bytes32)

- **Signature**: `computeAccountAddress(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 890:172:462

**Signature:**
```solidity
/// @notice Computes the expected address of a Nexus contract using the factory's deterministic deployment
///  algorithm.
///  @param initData Initialization data to be called on the new Smart Account.
///  @param salt Unique salt for the Smart Account creation.
///  @return expectedAddress The expected address at which the Nexus contract will be deployed if the provided
///  parameters are used.
function computeAccountAddress(bytes calldata initData, bytes32 salt) external view returns (address payable expectedAddress);;
```
