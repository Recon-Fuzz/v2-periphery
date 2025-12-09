# Function: setETHAmount(uint256)

**Contract**: [test/mocks/MockNativeETHHook.sol/contract_MockNativeETHHook.md]

## Metadata

- **Contract**: MockNativeETHHook
- **Signature**: `setETHAmount(uint256)`
- **Visibility**: external
- **Source Range**: 2244:84:599

## Implementation

```solidity
/// @notice Set the ETH amount for the next execution
///  @param amount_ Amount of ETH to send
function setETHAmount(uint256 amount_) external {
    ethAmount = amount_;
}
```

## State Variable Writes

- **ethAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockNativeETHHook.setETHAmount(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Set the ETH amount for the next execution
 @param amount_ Amount of ETH to send
