# Function: execute()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `execute()`
- **Visibility**: external
- **Source Range**: 4580:559:590

## Implementation

```solidity
/// @notice Simple execute function that can be called by hooks
function execute() external payable {
    emit ExecuteCalled(msg.sender, msg.value);
    totalReceived += msg.value;
    if (msg.value > 0) {
        uint256 usdcAmount = msg.value / 1e12;
        if (IERC20(USDC).balanceOf(address(this)) >= usdcAmount) {
            IERC20(USDC).transfer(msg.sender, usdcAmount);
        }
    }
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **totalReceived** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.execute() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Simple execute function that can be called by hooks
