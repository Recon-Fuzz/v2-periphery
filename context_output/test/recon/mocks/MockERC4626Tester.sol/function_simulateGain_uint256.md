# Function: simulateGain(uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 8704:170:637

## Implementation

```solidity
/// @dev Simulate a gain on the vault's assets (similar to Yearn's profit taking)
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
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.simulateGain(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev Simulate a gain on the vault's assets (similar to Yearn's profit taking)
