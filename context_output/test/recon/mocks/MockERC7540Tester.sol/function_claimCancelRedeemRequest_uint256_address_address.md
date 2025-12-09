# Function: claimCancelRedeemRequest(uint256,address,address)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10839:408:641

## Implementation

```solidity
function claimCancelRedeemRequest(uint256 requestId, address receiver, address) external returns (uint256 shares) {
    RedeemRequestStruct storage request = redeemRequests[requestId];
    shares = request.shares;
    request.canceled = true;
    pendingCancelRedeem[requestId] = false;
    _mint(receiver, shares);
}
```

## Related Implementations

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7079:471:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:_mint(address,uint256)`

```solidity
function _mint(address to, uint256 amount) virtual internal {
    uint256 newTotalSupply = totalSupply + amount;
    if (newTotalSupply < totalSupply) revert MintOverflow(totalSupply, amount);
    totalSupply = newTotalSupply;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(address(0), to, amount);
}
```

## State Variable Reads

- **redeemRequests** (`mapping(uint256 => struct MockERC7540Tester.RedeemRequestStruct)`)
- **totalSupply** (`uint256`)

## State Variable Writes

- **pendingCancelRedeem** (`mapping(uint256 => bool)`)
- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC7540Tester.claimCancelRedeemRequest(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 1)
      💬 Args: [receiver, shares]
      👁️  Def: internal
```
