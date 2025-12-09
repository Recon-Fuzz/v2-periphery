# Function: getOutAmount(address)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `getOutAmount(address)`
- **Visibility**: external
- **Source Range**: 960:96:593

## Implementation

```solidity
function getOutAmount(address) external view returns (uint256) {
    return outAmount;
}
```

## State Variable Reads

- **outAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.getOutAmount(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice The amount of tokens processed by the hook in a given caller context, subject to fees after update
 @dev This is the primary output value used by subsequent hooks
 @param caller The caller address for context identification
 @return The amount of tokens (assets or shares) processed
