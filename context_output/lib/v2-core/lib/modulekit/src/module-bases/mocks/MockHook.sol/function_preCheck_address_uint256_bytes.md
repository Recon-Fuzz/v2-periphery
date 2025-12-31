# Function: preCheck(address,uint256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `preCheck(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 632:302:203
- **Inherited From**: ERC7579HookBase

## Implementation

```solidity
///  Precheck hook
///  @param msgSender sender of the transaction
///  @param msgValue value of the transaction
///  @param msgData data of the transaction
///  @return hookData data for the postcheck hook
function preCheck(address msgSender, uint256 msgValue, bytes calldata msgData) virtual external returns (bytes memory hookData) {
    return _preCheck(_getAccount(), msgSender, msgValue, msgData);
}
```

## Related Implementations

### _preCheck(address,address,uint256,bytes)

- **Kind**: internal
- **Source**: 303:216:221
- **Link**: `lib/v2-core/lib/modulekit/src/module-bases/mocks/MockHook.sol:MockHook:_preCheck(address,address,uint256,bytes)`

```solidity
function _preCheck(address account, address msgSender, uint256 msgValue, bytes calldata msgData) override internal returns (bytes memory hookData) {}
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

- **trustedForwarder** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7579HookBase.preCheck(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockHook._preCheck(address,address,uint256,bytes) (NodeID: 1)
      💬 Args: [_getAccount(), msgSender, msgValue, msgData]
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

 Precheck hook
 @param msgSender sender of the transaction
 @param msgValue value of the transaction
 @param msgData data of the transaction
 @return hookData data for the postcheck hook
