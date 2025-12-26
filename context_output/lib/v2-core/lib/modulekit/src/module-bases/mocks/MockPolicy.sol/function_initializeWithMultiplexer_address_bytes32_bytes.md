# Function: initializeWithMultiplexer(address,bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockPolicy.sol/contract_MockPolicy.md]

## Metadata

- **Contract**: MockPolicy
- **Signature**: `initializeWithMultiplexer(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 692:200:224

## Implementation

```solidity
function initializeWithMultiplexer(address account, bytes32 configId, bytes calldata) external {
    userOpState[configId][msg.sender][account] = 1;
}
```

## State Variable Writes

- **userOpState** (`mapping(bytes32 => mapping(address => mapping(address => uint256)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockPolicy.initializeWithMultiplexer(address,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
