# Contract: MockMultisig

## Metadata

- **Name**: MockMultisig
- **Type**: Contract
- **Path**: test/mocks/MockMultisig.sol
- **Documentation**: @title MockMultisig
   @notice Simulates a multisig wallet that can batch multiple calls in a single transaction
   @dev Used for testing governance operations that would be batched in production

## Public/External Functions

### executeBatch(address[],bytes[])

- **Signature**: `executeBatch(address[],bytes[])`
- **Visibility**: external
- **Source Range**: 520:457:598
- **Details**: [function_executeBatch_address[]_bytes[].md](./function_executeBatch_address[]_bytes[].md)

**Signature:**
```solidity
/// @notice Execute multiple calls in a single transaction
///  @param targets Array of target contract addresses
///  @param data Array of calldata for each call
///  @return results Array of return data from each call
function executeBatch(address[] calldata targets, bytes[] calldata data) external returns (bytes[] memory results);
```

### execute(address,bytes)

- **Signature**: `execute(address,bytes)`
- **Visibility**: external
- **Source Range**: 1185:237:598
- **Details**: [function_execute_address_bytes.md](./function_execute_address_bytes.md)

**Signature:**
```solidity
/// @notice Execute a single call (for granting roles, etc.)
///  @param target Target contract address
///  @param data Calldata for the call
///  @return result Return data from the call
function execute(address target, bytes calldata data) external returns (bytes memory result);
```
