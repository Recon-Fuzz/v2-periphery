# Function: isOperator(address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 4710:142:641

## Implementation

```solidity
function isOperator(address controller, address operator) external view returns (bool) {
    return operators[controller][operator];
}
```

## State Variable Reads

- **operators** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.isOperator(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
