# Function: totalSupply()

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 1340:100:196

## Implementation

```solidity
function totalSupply() override external view returns (uint256) {
    return _totalSupply;
}
```

## State Variable Reads

- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the amount of tokens in existence.
