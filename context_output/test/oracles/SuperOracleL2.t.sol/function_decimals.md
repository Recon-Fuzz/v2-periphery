# Function: decimals()

**Contract**: [test/oracles/SuperOracleL2.t.sol/contract_MockAggregatorGasConsumerOnDecimals.md]

## Metadata

- **Contract**: MockAggregatorGasConsumerOnDecimals
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 82111:454:625

## Implementation

```solidity
function decimals() external view returns (uint8) {
    uint256 initialGas = gasleft();
    uint256 targetGas = initialGas / 64;
    while (gasleft() > targetGas) {
        assembly {
            let x := keccak256(0, 32)
            x := keccak256(0, 32)
            x := keccak256(0, 32)
        }
    }
    revert("Gas consumed on decimals");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockAggregatorGasConsumerOnDecimals.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
