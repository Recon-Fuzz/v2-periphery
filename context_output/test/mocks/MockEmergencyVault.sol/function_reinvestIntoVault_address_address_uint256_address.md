# Function: reinvestIntoVault(address,address,uint256,address)

**Contract**: [test/mocks/MockEmergencyVault.sol/contract_MockEmergencyVault.md]

## Metadata

- **Contract**: MockEmergencyVault
- **Signature**: `reinvestIntoVault(address,address,uint256,address)`
- **Visibility**: external
- **Source Range**: 3600:1020:591

## Implementation

```solidity
/// @notice Reinvest tokens into a SuperVault or any ERC4626 vault
///  @param token_ The token to reinvest
///  @param vault_ The vault to deposit into
///  @param amount_ The amount to reinvest
///  @return shares The amount of shares received
function reinvestIntoVault(address token_, address vault_, uint256 amount_, address receiver_) external onlyOwner() returns (uint256 shares) {
    if (token_ == address(0)) revert ZERO_ADDRESS();
    if (vault_ == address(0)) revert ZERO_ADDRESS();
    if (amount_ == 0) revert ZERO_AMOUNT();
    if (getTokenBalance(token_) < amount_) revert INSUFFICIENT_BALANCE();
    IERC4626 vault = IERC4626(vault_);
    if (vault.asset() != token_) revert TRANSFER_FAILED();
    if (tokenBalances[token_] > amount_) {
        tokenBalances[token_] -= amount_;
    } else {
        tokenBalances[token_] = 0;
    }
    IERC20(token_).approve(vault_, amount_);
    shares = vault.deposit(amount_, receiver_);
    emit TokensReinvested(token_, vault_, amount_, shares);
}
```

## Related Implementations

### getTokenBalance(address)

- **Kind**: internal
- **Source**: 5303:158:591
- **Link**: `test/mocks/MockEmergencyVault.sol:MockEmergencyVault:getTokenBalance(address)`

```solidity
/// @notice Get the balance of a specific token in the emergency vault
///  @param token_ The token address
///  @return The token balance
function getTokenBalance(address token_) public view returns (uint256) {
    return tokenBalances[token_] + IERC20(token_).balanceOf(address(this));
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 2045:95:591
- **Link**: `test/mocks/MockEmergencyVault.sol:MockEmergencyVault:onlyOwner()`

```solidity
modifier onlyOwner() {
    if (msg.sender != owner) revert UNAUTHORIZED();
    _;
}
```

## External Calls

- **IERC4626::asset()**
- **IERC20::approve(address,uint256)**
- **IERC4626::deposit(uint256,address)**

## State Variable Reads

- **tokenBalances** (`mapping(address => uint256)`)
- **owner** (`address`)

## State Variable Writes

- **tokenBalances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockEmergencyVault.reinvestIntoVault(address,address,uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MockEmergencyVault.getTokenBalance(address) (NodeID: 1)
  │   💬 Args: [token_]
  │   👁️  Def: public
  └─ [1] 🔒 MODIFIER: MockEmergencyVault.onlyOwner() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Reinvest tokens into a SuperVault or any ERC4626 vault
 @param token_ The token to reinvest
 @param vault_ The vault to deposit into
 @param amount_ The amount to reinvest
 @return shares The amount of shares received
