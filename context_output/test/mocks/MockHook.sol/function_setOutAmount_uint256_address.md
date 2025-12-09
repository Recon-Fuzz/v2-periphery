# Function: setOutAmount(uint256,address)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 855:99:593

## Implementation

```solidity
function setOutAmount(uint256 _outAmount, address) external {
    outAmount = _outAmount;
}
```

## State Variable Writes

- **outAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.setOutAmount(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
