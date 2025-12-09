# Interface: IERC6682

## Metadata

- **Name**: IERC6682
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/Flashloan.sol

## Public/External Functions

### flashFeeToken()

- **Signature**: `flashFeeToken()`
- **Visibility**: external
- **Source Range**: 136:57:213

**Signature:**
```solidity
function flashFeeToken() external view returns (address);;
```

### flashFee(address,uint256)

- **Signature**: `flashFee(address,uint256)`
- **Visibility**: external
- **Source Range**: 198:82:213

**Signature:**
```solidity
function flashFee(address token, uint256 tokenId) external view returns (uint256);;
```

### availableForFlashLoan(address,uint256)

- **Signature**: `availableForFlashLoan(address,uint256)`
- **Visibility**: external
- **Source Range**: 285:92:213

**Signature:**
```solidity
function availableForFlashLoan(address token, uint256 tokenId) external view returns (bool);;
```
