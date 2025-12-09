# Function: reclaimTokens(uint256)

**Contract**: [test/draft/src/UP/UpDistributor.sol/contract_UpDistributor.md]

## Metadata

- **Contract**: UpDistributor
- **Signature**: `reclaimTokens(uint256)`
- **Visibility**: external
- **Source Range**: 3552:268:551

## Implementation

```solidity
///  @notice Allow the foundation to reclaim unclaimed tokens
///  @param amount The amount of tokens to reclaim
function reclaimTokens(uint256 amount) external onlyOwner() {
    uint256 balance = token.balanceOf(address(this));
    if (amount > balance) revert NO_TOKENS_TO_RECLAIM();
    emit TokensReclaimed(amount);
    token.safeTransfer(owner(), amount);
}
```

## Related Implementations

### owner()

- **Kind**: internal
- **Source**: 1638:85:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 1500:62:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1796:162:251
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    if (owner() != _msgSender()) {
        revert OwnableUnauthorizedAccount(_msgSender());
    }
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **token** (`contract IERC20`) [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpDistributor.reclaimTokens(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Ownable.owner() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 2)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 4)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 5)
      │   💬 Args: [no args]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 6)
          💬 Args: [no args]
          👁️  Def: internal
```

## Documentation

### Function Documentation

 @notice Allow the foundation to reclaim unclaimed tokens
 @param amount The amount of tokens to reclaim
