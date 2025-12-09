# Function: setLossOnWithdraw(uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 8962:188:637

## Implementation

```solidity
/// @dev Set the loss on withdraw as percentage of the assets being withdrawn
function setLossOnWithdraw(uint256 _lossOnWithdraw) public {
    _lossOnWithdraw %= MAX_BPS + 1;
    lossOnWithdraw = _lossOnWithdraw;
}
```

## State Variable Reads

- **MAX_BPS** (`uint256`)

## State Variable Writes

- **lossOnWithdraw** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626Tester.setLossOnWithdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Set the loss on withdraw as percentage of the assets being withdrawn
