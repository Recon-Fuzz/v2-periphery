# Function: getData()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `getData()`
- **Visibility**: external
- **Source Range**: 1521:96:165

## Implementation

```solidity
function getData() external view returns (bytes memory) {
    return data[msg.sender];
}
```

## State Variable Reads

- **data** (`mapping(address => bytes)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockFallback.getData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
