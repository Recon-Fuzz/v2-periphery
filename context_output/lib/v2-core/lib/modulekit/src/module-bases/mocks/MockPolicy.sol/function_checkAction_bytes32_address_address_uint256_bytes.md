# Function: checkAction(bytes32,address,address,uint256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockPolicy.sol/contract_MockPolicy.md]

## Metadata

- **Contract**: MockPolicy
- **Signature**: `checkAction(bytes32,address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1159:275:224

## Implementation

```solidity
function checkAction(bytes32 id, address account, address, uint256, bytes calldata) external returns (uint256) {
    actionState[id][msg.sender][account] += 1;
    return validationData[account];
}
```

## State Variable Reads

- **validationData** (`mapping(address => uint256)`)

## State Variable Writes

- **actionState** (`mapping(bytes32 => mapping(address => mapping(address => uint256)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockPolicy.checkAction(bytes32,address,address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
