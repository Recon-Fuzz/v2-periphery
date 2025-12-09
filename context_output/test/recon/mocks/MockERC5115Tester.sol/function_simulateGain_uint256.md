# Function: simulateGain(uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 5223:175:639

## Implementation

```solidity
function simulateGain(uint256 gainAmount) external {
    MockERC20(yieldToken).transferFrom(msg.sender, address(this), gainAmount);
    totalGains += gainAmount;
}
```

## External Calls

- **MockERC20::transferFrom(address,address,uint256)**

## State Variable Writes

- **totalGains** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.simulateGain(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
