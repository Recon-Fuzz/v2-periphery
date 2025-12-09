# Function: executeProviderRemoval()

**Contract**: [test/mocks/MockSuperOracle.sol/contract_MockSuperOracle.md]

## Metadata

- **Contract**: MockSuperOracle
- **Signature**: `executeProviderRemoval()`
- **Visibility**: external
- **Source Range**: 1121:169:605

## Implementation

```solidity
function executeProviderRemoval() external {
    providerRemoved = true;
}
```

## State Variable Writes

- **providerRemoved** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracle.executeProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
