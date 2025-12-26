# Function: checkUserOpPolicy(bytes32,struct PackedUserOperation)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockPolicy.sol/contract_MockPolicy.md]

## Metadata

- **Contract**: MockPolicy
- **Signature**: `checkUserOpPolicy(bytes32,struct PackedUserOperation)`
- **Visibility**: external
- **Source Range**: 898:255:224

## Implementation

```solidity
function checkUserOpPolicy(bytes32 id, PackedUserOperation calldata userOp) external returns (uint256) {
    userOpState[id][msg.sender][userOp.sender] += 1;
    return validationData[userOp.sender];
}
```

## State Variable Reads

- **validationData** (`mapping(address => uint256)`)

## State Variable Writes

- **userOpState** (`mapping(bytes32 => mapping(address => mapping(address => uint256)))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockPolicy.checkUserOpPolicy(bytes32,struct PackedUserOperation) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
