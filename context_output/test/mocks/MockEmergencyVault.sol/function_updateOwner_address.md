# Function: updateOwner(address)

**Contract**: [test/mocks/MockEmergencyVault.sol/contract_MockEmergencyVault.md]

## Metadata

- **Contract**: MockEmergencyVault
- **Signature**: `updateOwner(address)`
- **Visibility**: external
- **Source Range**: 4729:237:591

## Implementation

```solidity
/// @notice Update the owner of the emergency vault
///  @param newOwner_ The new owner address
function updateOwner(address newOwner_) external onlyOwner() {
    if (newOwner_ == address(0)) revert ZERO_ADDRESS();
    address oldOwner = owner;
    owner = newOwner_;
    emit OwnerUpdated(oldOwner, newOwner_);
}
```

## Related Implementations

### onlyOwner()

- **Kind**: modifier
- **Source**: 2045:95:591
- **Link**: `test/mocks/MockEmergencyVault.sol:MockEmergencyVault:onlyOwner()`

```solidity
modifier onlyOwner() {
    if (msg.sender != owner) revert UNAUTHORIZED();
    _;
}
```

## State Variable Reads

- **owner** (`address`)

## State Variable Writes

- **owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockEmergencyVault.updateOwner(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: MockEmergencyVault.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Update the owner of the emergency vault
 @param newOwner_ The new owner address
