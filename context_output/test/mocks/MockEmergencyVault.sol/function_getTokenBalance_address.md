# Function: getTokenBalance(address)

**Contract**: [test/mocks/MockEmergencyVault.sol/contract_MockEmergencyVault.md]

## Metadata

- **Contract**: MockEmergencyVault
- **Signature**: `getTokenBalance(address)`
- **Visibility**: public
- **Source Range**: 5303:158:591

## Implementation

```solidity
/// @notice Get the balance of a specific token in the emergency vault
///  @param token_ The token address
///  @return The token balance
function getTokenBalance(address token_) public view returns (uint256) {
    return tokenBalances[token_] + IERC20(token_).balanceOf(address(this));
}
```

## External Calls

- **IERC20::balanceOf(address)**

## State Variable Reads

- **tokenBalances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockEmergencyVault.getTokenBalance(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Get the balance of a specific token in the emergency vault
 @param token_ The token address
 @return The token balance
