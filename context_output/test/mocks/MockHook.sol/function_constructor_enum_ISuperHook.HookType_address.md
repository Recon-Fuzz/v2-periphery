# Function: constructor(enum ISuperHook.HookType,address)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `constructor(enum ISuperHook.HookType,address)`
- **Visibility**: public
- **Source Range**: 644:109:593

## Implementation

```solidity
constructor(HookType _hookType, address _asset) {
    hookType = _hookType;
    asset = _asset;
}
```

## State Variable Writes

- **hookType** (`enum ISuperHook.HookType`)
- **asset** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockHook.constructor(enum ISuperHook.HookType,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockHook
```
