# Function: simulateLoss(uint256)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 12320:157:641

## Implementation

```solidity
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
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.simulateLoss(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
