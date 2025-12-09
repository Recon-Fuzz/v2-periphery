# Function: name()

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC721.sol/contract_MockERC721.md]

## Metadata

- **Contract**: MockERC721
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 711:92:197

## Implementation

```solidity
function name() override external view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC721.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice A descriptive name for a collection of NFTs in this contract
