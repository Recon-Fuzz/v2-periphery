# Function: setOutputAmount(uint256)

**Contract**: [test/mocks/MockHookWithSlippage.sol/contract_MockHookWithSlippage.md]

## Metadata

- **Contract**: MockHookWithSlippage
- **Signature**: `setOutputAmount(uint256)`
- **Visibility**: external
- **Source Range**: 724:90:595

## Implementation

```solidity
function setOutputAmount(uint256 _amount) external {
    outputAmount = _amount;
}
```

## State Variable Writes

- **outputAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHookWithSlippage.setOutputAmount(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
