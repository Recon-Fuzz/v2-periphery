# Function: simulateLoss(uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 8455:157:637

## Implementation

```solidity
/// @dev Simulate a loss on the vault's assets
function simulateLoss(uint256 lossAmount) external {
    MockERC20(asset).transfer(address(0xbeef), lossAmount);
    totalLosses += lossAmount;
}
```

## External Calls

- **MockERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Writes

- **totalLosses** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.simulateLoss(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev Simulate a loss on the vault's assets
