# Function: setValidationData(address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockPolicy.sol/contract_MockPolicy.md]

## Metadata

- **Contract**: MockPolicy
- **Signature**: `setValidationData(address,uint256)`
- **Visibility**: external
- **Source Range**: 560:126:224

## Implementation

```solidity
function setValidationData(address account, uint256 validation) external {
    validationData[account] = validation;
}
```

## State Variable Writes

- **validationData** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockPolicy.setValidationData(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
