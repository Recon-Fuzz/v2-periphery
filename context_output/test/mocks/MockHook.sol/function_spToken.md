# Function: spToken()

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `spToken()`
- **Visibility**: external
- **Source Range**: 3266:94:593

## Implementation

```solidity
function spToken() override external pure returns (address) {
    return address(0);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.spToken() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice The SuperPosition (SP) token associated with this hook
 @dev For vault hooks, this would be the tokenized position representing shares
 @return The address of the SP token, or address(0) if not applicable
