# Function: setLossOnWithdraw(uint256)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 12565:188:641

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
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.setLossOnWithdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Set the loss on withdraw as percentage of the assets being withdrawn
