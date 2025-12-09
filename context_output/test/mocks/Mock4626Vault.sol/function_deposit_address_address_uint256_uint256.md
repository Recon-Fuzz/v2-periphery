# Function: deposit(address,address,uint256,uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `deposit(address,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3323:727:585

## Implementation

```solidity
function deposit(address receiver, address, uint256 assets, uint256) public returns (uint256 shares) {
    console2.log("--- receiver", receiver);
    require(assets > 0, AMOUNT_NOT_VALID());
    uint256 amount = lessAmount ? (assets / 2) : assets;
    shares = amount;
    _totalAssets += amount;
    _totalShares += shares;
    amountOf[receiver] += amount;
    depositTimestamps[receiver] = block.timestamp;
    IERC20(_asset).transferFrom(msg.sender, address(this), assets);
    _mint(receiver, shares);
    emit Deposit(msg.sender, receiver, assets, shares);
}
```

## Related Implementations

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 851:129:26
- **Link**: `lib/forge-std/src/console.sol:console:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castToPure(_sendLogPayloadImplementation)(payload);
}
```

### _castToPure(function (bytes)

- **Kind**: internal
- **Source**: 649:196:26
- **Link**: `lib/forge-std/src/console.sol:console:_castToPure(function (bytes) view)`

```solidity
function _castToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7362:208:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
///  @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
///  Relies on the `_update` mechanism
///  Emits a {Transfer} event with `from` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _mint(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(address(0), account, value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 5912:1107:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    if (from == address(0)) {
        _totalSupply += value;
    } else {
        uint256 fromBalance = _balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            _balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            _totalSupply -= value;
        }
    } else {
        unchecked {
            _balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

## External Calls

- **IERC20::transferFrom(address,address,uint256)**

## State Variable Reads

- **lessAmount** (`bool`)
- **_asset** (`address`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_totalAssets** (`uint256`)
- **_totalShares** (`uint256`)
- **amountOf** (`mapping(address => uint256)`)
- **depositTimestamps** (`mapping(address => uint256)`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.deposit(address,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1)
  │   💬 Args: ["--- receiver", receiver]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadImplementation]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 4)
      💬 Args: [receiver, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 5)
        💬 Args: [address(0), account, value]
        👁️  Def: internal
```
