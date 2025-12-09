# Function: setOperator(address,bool)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 4488:216:641

## Implementation

```solidity
function setOperator(address operator, bool approved) external returns (bool) {
    operators[msg.sender][operator] = approved;
    emit OperatorSet(msg.sender, operator, approved);
    return true;
}
```

## State Variable Writes

- **operators** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.setOperator(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
