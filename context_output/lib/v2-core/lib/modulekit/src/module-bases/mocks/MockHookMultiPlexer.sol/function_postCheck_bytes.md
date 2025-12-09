# Function: postCheck(bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol/contract_MockHookMultiPlexer.md]

## Metadata

- **Contract**: MockHookMultiPlexer
- **Signature**: `postCheck(bytes)`
- **Visibility**: external
- **Source Range**: 1036:151:203
- **Inherited From**: ERC7579HookBase

## Implementation

```solidity
///  Postcheck hook
///  @param hookData data from the precheck hook
function postCheck(bytes calldata hookData) virtual external {
    _postCheck(_getAccount(), hookData);
}
```

## Related Implementations

### _postCheck(address,bytes)

- **Kind**: internal
- **Source**: 2625:843:222
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHookMultiPlexer.sol:MockHookMultiPlexer:_postCheck(address,bytes)`

```solidity
function _postCheck(address account, bytes calldata hookData) override internal {
    uint256 length = hooks[account].length;
    if (length == 0) return;
    bytes[] memory _hookData = new bytes[](length);
    if (hookData.length != 0) {
        _hookData = abi.decode(hookData, (bytes[]));
    }
    for (uint256 i = 0; i < length; i++) {
        Hook storage _hook = hooks[account][i];
        if (_hook.isInitialized) {
            (bool success, ) = _hook.hook.call(abi.encodePacked(abi.encodeCall(ERC7579HookBase.postCheck, (_hookData[i])), address(this), msg.sender));
            if (!success) revert PostCheckFailed(_hook.hook);
        }
    }
}
```

### _getAccount()

- **Kind**: internal
- **Source**: 1182:584:230
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/utils/TrustedForwarder.sol:TrustedForwarder:_getAccount()`

```solidity
///  Get the sender of the transaction
///  @return account the sender of the transaction
function _getAccount() internal view returns (address account) {
    account = msg.sender;
    address _account;
    address forwarder;
    if (msg.data.length >= 40) {
        assembly {
            _account := shr(96, calldataload(sub(calldatasize(), 20)))
            forwarder := shr(96, calldataload(sub(calldatasize(), 40)))
        }
        if ((forwarder == msg.sender) && isTrustedForwarder(forwarder, _account)) {
            account = _account;
        }
    }
}
```

### isTrustedForwarder(address,address)

- **Kind**: internal
- **Source**: 906:153:230
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/utils/TrustedForwarder.sol:TrustedForwarder:isTrustedForwarder(address,address)`

```solidity
///  Check if a forwarder is trusted for an account
///  @param forwarder The address of the forwarder
///  @param account The address of the account
///  @return true if the forwarder is trusted for the account
function isTrustedForwarder(address forwarder, address account) public view returns (bool) {
    return forwarder == trustedForwarder[account];
}
```

## State Variable Reads

- **hooks** (`mapping(address => struct MockHookMultiPlexer.Hook[])`)
- **trustedForwarder** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579HookBase.postCheck(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockHookMultiPlexer._postCheck(address,bytes) (NodeID: 1)
      💬 Args: [_getAccount(), hookData]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TrustedForwarder._getAccount() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: TrustedForwarder.isTrustedForwarder(address,address) (NodeID: 3)
          💬 Args: [forwarder, _account]
          👁️  Def: public
```

## Documentation

### Function Documentation

 Postcheck hook
 @param hookData data from the precheck hook
