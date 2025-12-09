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

## Related Implementations

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
}
```

## State Variable Writes

- **uniswap** (`contract ISwapRouter`) [lib/v2-core/lib/modulekit/src/integrations/interfaces/uniswap/v3/ISwapRouter.sol/interface_ISwapRouter.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockFactory.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockFactory
  └─ [1] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 1)
      💬 Args: [SWAPROUTER_ADDRESS, address(_mockUniswap).code]
      👁️  Def: internal
```
