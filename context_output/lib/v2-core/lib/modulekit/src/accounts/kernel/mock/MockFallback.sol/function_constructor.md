# Function: constructor()

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_MockFallback.md]

## Metadata

- **Contract**: MockFallback
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 721:52:165

## Implementation

```solidity
constructor() {
    callee = new Callee();
}
```

## State Variable Writes

- **callee** (`contract Callee`) [lib/v2-core/lib/modulekit/src/accounts/kernel/mock/MockFallback.sol/contract_Callee.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockFallback.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockFallback
```
