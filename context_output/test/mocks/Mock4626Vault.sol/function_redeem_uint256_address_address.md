# Function: redeem(uint256,address,address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 4056:1216:585

## Implementation

```solidity
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256 assets) {
    require(shares > 0, AMOUNT_NOT_VALID());
    require(shares <= _totalShares, AMOUNT_NOT_VALID());
    if ((yield > 0) && (depositTimestamps[owner] > 0)) {
        uint256 timeElapsed = block.timestamp - depositTimestamps[owner];
        uint256 yieldFactor = (yield * timeElapsed) / (365 days);
        assets = shares + ((shares * yieldFactor) / yield_precision);
    } else {
        assets = shares;
    }
    console2.log("--- _totalAssets before redeem", _totalAssets);
    console2.log("--- _totalShares before redeem", _totalShares);
    console2.log("--- _amountOf[owner]", amountOf[owner]);
    console2.log("--- owner", owner);
    _totalAssets -= assets;
    _totalShares -= shares;
    amountOf[owner] -= assets;
    depositTimestamps[owner] = 0;
    IERC20(_asset).transfer(receiver, assets);
    _burn(owner, shares);
    emit Withdraw(msg.sender, receiver, owner, assets, shares);
}
```

## Related Implementations

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
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

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 7888:206:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
///  Relies on the `_update` mechanism.
///  Emits a {Transfer} event with `to` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead
function _burn(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    _update(account, address(0), value);
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

- **IERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## State Variable Reads

- **_totalShares** (`uint256`)
- **yield** (`uint256`)
- **depositTimestamps** (`mapping(address => uint256)`)
- **yield_precision** (`uint256`)
- **_totalAssets** (`uint256`)
- **amountOf** (`mapping(address => uint256)`)
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
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.redeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["--- _totalAssets before redeem", _totalAssets]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadImplementation]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 4)
  │   💬 Args: ["--- _totalShares before redeem", _totalShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadImplementation]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 7)
  │   💬 Args: ["--- _amountOf[owner]", amountOf[owner]]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadImplementation]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 10)
  │   💬 Args: ["--- owner", owner]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console._castToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadImplementation]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 13)
      💬 Args: [owner, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 14)
        💬 Args: [account, address(0), value]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Burns exactly shares from owner and sends assets of underlying tokens to receiver.
 - MUST emit the Withdraw event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
   redeem execution, and are accounted for during redeem.
 - MUST revert if all of shares cannot be redeemed (due to withdrawal limit being reached, slippage, the owner
   not having enough shares, etc).
 NOTE: some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
 Those methods should be performed separately.
