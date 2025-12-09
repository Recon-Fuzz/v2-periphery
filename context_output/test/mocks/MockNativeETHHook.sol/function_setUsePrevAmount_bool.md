# Function: setUsePrevAmount(bool)

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `setUsePrevAmount(bool)`
- **Visibility**: external
- **Source Range**: 2450:91:599

## Implementation

```solidity
/// @notice Set whether to use previous hook amount
///  @param usePrev_ Whether to use previous hook amount
function setUsePrevAmount(bool usePrev_) external {
    usePrevAmount = usePrev_;
}
```

## State Variable Writes

- **usePrevAmount** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockNativeETHHook.setUsePrevAmount(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Set whether to use previous hook amount
 @param usePrev_ Whether to use previous hook amount
