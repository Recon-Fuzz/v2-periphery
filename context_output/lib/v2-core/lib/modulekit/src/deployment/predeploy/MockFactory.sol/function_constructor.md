# Function: constructor()

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/MockFactory.sol/contract_MockFactory.md]

## Metadata

- **Contract**: MockFactory
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 420:261:188

## Implementation

```solidity
constructor() {
    if (SWAPROUTER_ADDRESS.code.length == 0) {
        MockUniswap _mockUniswap = new MockUniswap();
        etch(SWAPROUTER_ADDRESS, address(_mockUniswap).code);
        uniswap = ISwapRouter(SWAPROUTER_ADDRESS);
    }
}
```

## State Variable Writes

- **uniswap** (`contract ISwapRouter`) [lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/ISwapRouter.sol/interface_ISwapRouter.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockFactory.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockFactory
```
