# Function: simulateGain(uint256)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 12144:170:641

## Implementation

```solidity
function simulateGain(uint256 gainAmount) external {
    MockERC20(asset).transferFrom(msg.sender, address(this), gainAmount);
    totalGains += gainAmount;
}
```

## External Calls

- **MockERC20::transferFrom(address,address,uint256)**

## State Variable Writes

- **totalGains** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.simulateGain(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
