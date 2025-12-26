# Function: subtype()

**Contract**: [lib/v2-core/src/hooks/tokens/erc20/TransferERC20Hook.sol/contract_TransferERC20Hook.md]

## Metadata

- **Contract**: TransferERC20Hook
- **Signature**: `subtype()`
- **Visibility**: external
- **Source Range**: 8553:83:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function subtype() external view returns (bytes32) {
    return SUB_TYPE;
}
```

## State Variable Reads

- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.subtype() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Returns the specific subtype identification for this hook
 @dev Used to categorize hooks beyond the basic HookType
      For example, a hook might be of type INFLOW but subtype VAULT_DEPOSIT
 @return A bytes32 identifier for the specific hook functionality
