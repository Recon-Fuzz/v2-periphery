# Function: setShouldFailBuild(bool)

**Contract**: [test/mocks/MockSuperHook.sol/contract_MockSuperHook.md]

## Metadata

- **Contract**: MockSuperHook
- **Signature**: `setShouldFailBuild(bool)`
- **Visibility**: external
- **Source Range**: 967:101:604

## Implementation

```solidity
function setShouldFailBuild(bool _shouldFail) external {
    shouldFailBuild = _shouldFail;
}
```

## State Variable Writes

- **shouldFailBuild** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperHook.setShouldFailBuild(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
