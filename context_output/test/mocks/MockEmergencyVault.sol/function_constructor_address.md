# Function: constructor(address)

**Contract**: [test/mocks/MockEmergencyVault.sol/contract_MockEmergencyVault.md]

## Metadata

- **Contract**: MockEmergencyVault
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2425:116:591

## Implementation

```solidity
/// @notice Initialize the emergency vault
///  @param owner_ The owner address of the vault
constructor(address owner_) {
    if (owner_ == address(0)) revert ZERO_ADDRESS();
    owner = owner_;
}
```

## State Variable Writes

- **owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockEmergencyVault.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockEmergencyVault
```

## Documentation

### Function Documentation

@notice Initialize the emergency vault
 @param owner_ The owner address of the vault
