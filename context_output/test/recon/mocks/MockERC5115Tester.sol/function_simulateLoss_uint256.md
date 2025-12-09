# Function: simulateLoss(uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 5055:162:639

## Implementation

```solidity
function simulateLoss(uint256 lossAmount) external {
    MockERC20(yieldToken).transfer(address(0xbeef), lossAmount);
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
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.simulateLoss(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
