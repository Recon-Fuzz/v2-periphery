# Function: constructor(address,bytes)

**Contract**: [lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol/contract_ERC1967Proxy.md]

## Metadata

- **Contract**: ERC1967Proxy
- **Signature**: `constructor(address,bytes)`
- **Visibility**: public
- **Source Range**: 1081:133:263

## Implementation

```solidity
///  @dev Initializes the upgradeable proxy with an initial implementation specified by `implementation`.
///  If `_data` is nonempty, it's used as data in a delegate call to `implementation`. This will typically be an
///  encoded function call, and allows initializing the storage of the proxy like a Solidity constructor.
///  Requirements:
///  - If `data` is empty, `msg.value` must be zero.
constructor(address implementation, bytes memory _data) payable {
    ERC1967Utils.upgradeToAndCall(implementation, _data);
}
```

## Related Implementations

### upgradeToAndCall(address,bytes)

- **Kind**: internal
- **Source**: 2264:344:264
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol:ERC1967Utils:upgradeToAndCall(address,bytes)`

```solidity
///  @dev Performs implementation upgrade with additional setup call if data is nonempty.
///  This function is payable only if the setup call is performed, otherwise `msg.value` is rejected
///  to avoid stuck value in the contract.
///  Emits an {IERC1967-Upgraded} event.
function upgradeToAndCall(address newImplementation, bytes memory data) internal {
    _setImplementation(newImplementation);
    emit IERC1967.Upgraded(newImplementation);
    if (data.length > 0) {
        Address.functionDelegateCall(newImplementation, data);
    } else {
        _checkNonPayable();
    }
}
```

### _setImplementation(address)

- **Kind**: internal
- **Source**: 1671:281:264
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol:ERC1967Utils:_setImplementation(address)`

```solidity
///  @dev Stores a new address in the ERC-1967 implementation slot.
function _setImplementation(address newImplementation) private {
    if (newImplementation.code.length == 0) {
        revert ERC1967InvalidImplementation(newImplementation);
    }
    StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = newImplementation;
}
```

### getAddressSlot(bytes32)

- **Kind**: internal
- **Source**: 1899:163:285
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getAddressSlot(bytes32)`

```solidity
///  @dev Returns an `AddressSlot` with member `value` located at `slot`.
function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r) {
    assembly ("memory-safe") {
        r.slot := slot
    }
}
```

### functionDelegateCall(address,bytes)

- **Kind**: internal
- **Source**: 3916:253:274
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:functionDelegateCall(address,bytes)`

```solidity
///  @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
///  but performing a delegate call.
function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
    (bool success, bytes memory returndata) = target.delegatecall(data);
    return verifyCallResultFromTarget(target, success, returndata);
}
```

### verifyCallResultFromTarget(address,bool,bytes)

- **Kind**: internal
- **Source**: 4437:582:274
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:verifyCallResultFromTarget(address,bool,bytes)`

```solidity
///  @dev Tool to verify that a low level call to smart-contract was successful, and reverts if the target
///  was not a contract or bubbling up the revert reason (falling back to {Errors.FailedCall}) in case
///  of an unsuccessful call.
function verifyCallResultFromTarget(address target, bool success, bytes memory returndata) internal view returns (bytes memory) {
    if (!success) {
        _revert(returndata);
    } else {
        if ((returndata.length == 0) && (target.code.length == 0)) {
            revert AddressEmptyCode(target);
        }
        return returndata;
    }
}
```

### _revert(bytes)

- **Kind**: internal
- **Source**: 5559:434:274
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Address.sol:Address:_revert(bytes)`

```solidity
///  @dev Reverts with returndata if present. Otherwise reverts with {Errors.FailedCall}.
function _revert(bytes memory returndata) private pure {
    if (returndata.length > 0) {
        assembly ("memory-safe") {
            revert(add(returndata, 0x20), mload(returndata))
        }
    } else {
        revert Errors.FailedCall();
    }
}
```

### _checkNonPayable()

- **Kind**: internal
- **Source**: 6113:122:264
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol:ERC1967Utils:_checkNonPayable()`

```solidity
///  @dev Reverts if `msg.value` is not zero. It can be used to avoid `msg.value` stuck in the contract
///  if an upgrade doesn't perform an initialization call.
function _checkNonPayable() private {
    if (msg.value > 0) {
        revert ERC1967NonPayable();
    }
}
```

## External Calls

- **address::delegatecall(bytes memory)**

## State Variable Writes

- **IMPLEMENTATION_SLOT** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ERC1967Proxy.constructor(address,bytes) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ERC1967Proxy
  └─ [1] ⚙️ FUNCTION: ERC1967Utils.upgradeToAndCall(address,bytes) (NodeID: 1)
      💬 Args: [implementation, _data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC1967Utils._setImplementation(address) (NodeID: 2)
    │   💬 Args: [newImplementation]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: StorageSlot.getAddressSlot(bytes32) (NodeID: 3)
    │     💬 Args: [IMPLEMENTATION_SLOT]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Address.functionDelegateCall(address,bytes) (NodeID: 4)
    │   💬 Args: [newImplementation, data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Address.verifyCallResultFromTarget(address,bool,bytes) (NodeID: 5)
    │     💬 Args: [target, success, returndata]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Address._revert(bytes) (NodeID: 6)
    │       💬 Args: [returndata]
    │       👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ERC1967Utils._checkNonPayable() (NodeID: 7)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

 @dev Initializes the upgradeable proxy with an initial implementation specified by `implementation`.
 If `_data` is nonempty, it's used as data in a delegate call to `implementation`. This will typically be an
 encoded function call, and allows initializing the storage of the proxy like a Solidity constructor.
 Requirements:
 - If `data` is empty, `msg.value` must be zero.
