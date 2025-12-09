# Function: totalAssets()

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 1529:117:590

## Implementation

```solidity
function totalAssets() override external view returns (uint256) {
    return USDC.balanceOf(address(this));
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.totalAssets() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns the total amount of the underlying asset that is “managed” by Vault.
 - SHOULD include any compounding that occurs from yield.
 - MUST be inclusive of any fees that are charged against assets in the Vault.
 - MUST NOT revert.
