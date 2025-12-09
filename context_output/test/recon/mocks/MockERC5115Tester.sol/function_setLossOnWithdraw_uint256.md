# Function: setLossOnWithdraw(uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 5486:188:639

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
┌─ [0] ⚙️ FUNCTION: MockERC5115Tester.setLossOnWithdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Set the loss on withdraw as percentage of the assets being withdrawn
