# Function: subtype()

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 759:90:593

## Implementation

```solidity
function subtype() external pure returns (bytes32) {
    return bytes32("Mock");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.subtype() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the specific subtype identification for this hook
 @dev Used to categorize hooks beyond the basic HookType
      For example, a hook might be of type INFLOW but subtype VAULT_DEPOSIT
 @return A bytes32 identifier for the specific hook functionality
