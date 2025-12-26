# Interface: IOdosRouterV2

## Metadata

- **Name**: IOdosRouterV2
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/odos/IOdosRouterV2.sol

## Structs

### swapTokenInfo

```solidity
struct swapTokenInfo {
    address inputToken;
    uint256 inputAmount;
    address inputReceiver;
    address outputToken;
    uint256 outputQuote;
    uint256 outputMin;
    address outputReceiver;
}
```

### permit2Info

```solidity
struct permit2Info {
    address contractAddress;
    uint256 nonce;
    uint256 deadline;
    bytes signature;
}
```

## Public/External Functions

### swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

- **Signature**: `swap(struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 826:223:463

**Signature:**
```solidity
/// @notice Externally facing interface for swapping two tokens
///  @param tokenInfo All information about the tokens being swapped
///  @param pathDefinition Encoded path definition for executor
///  @param executor Address of contract that will execute the path
///  @param referralCode referral code to specify the source of the swap
function swap(swapTokenInfo memory tokenInfo, bytes calldata pathDefinition, address executor, uint32 referralCode) external payable returns (uint256 amountOut);;
```

### swapPermit2(struct IOdosRouterV2.permit2Info,struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)

- **Signature**: `swapPermit2(struct IOdosRouterV2.permit2Info,struct IOdosRouterV2.swapTokenInfo,bytes,address,uint32)`
- **Visibility**: external
- **Source Range**: 1474:250:463

**Signature:**
```solidity
/// @notice Externally facing interface for swapping two tokens
///  @param permit2 All additional info for Permit2 transfers
///  @param tokenInfo All information about the tokens being swapped
///  @param pathDefinition Encoded path definition for executor
///  @param executor Address of contract that will execute the path
///  @param referralCode referral code to specify the source of the swap
function swapPermit2(permit2Info memory permit2, swapTokenInfo memory tokenInfo, bytes calldata pathDefinition, address executor, uint32 referralCode) external returns (uint256 amountOut);;
```

### swapCompact()

- **Signature**: `swapCompact()`
- **Visibility**: external
- **Source Range**: 1822:58:463

**Signature:**
```solidity
/// @notice Custom decoder to swap with compact calldata for efficient execution on L2s
function swapCompact() external payable returns (uint256);;
```
