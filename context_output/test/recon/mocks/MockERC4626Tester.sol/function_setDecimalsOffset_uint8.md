# Function: setDecimalsOffset(uint8)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `setDecimalsOffset(uint8)`
- **Visibility**: external
- **Source Range**: 9223:202:637

## Implementation

```solidity
/// @dev Set the decimal offset. Only possible with no supply.
function setDecimalsOffset(uint8 targetDecimalsOffset) external {
    if (totalSupply != 0) {
        revert("Supply is not zero");
    }
    decimalsOffset = targetDecimalsOffset;
}
```

## State Variable Writes

- **decimalsOffset** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.setDecimalsOffset(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev Set the decimal offset. Only possible with no supply.
