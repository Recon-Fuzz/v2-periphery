# Function: eip712Domain()

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5043:903:37
- **Inherited From**: EIP712Upgradeable

## Implementation

```solidity
/// @inheritdoc IERC5267
function eip712Domain() virtual public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions) {
    EIP712Storage storage $ = _getEIP712Storage();
    require(($._hashedName == 0) && ($._hashedVersion == 0), "EIP712: Uninitialized");
    return (hex"0f", _EIP712Name(), _EIP712Version(), block.chainid, address(this), bytes32(0), new uint256[](0));
}
```

## Related Implementations

### _getEIP712Storage()

- **Kind**: internal
- **Source**: 2606:156:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_getEIP712Storage()`

```solidity
function _getEIP712Storage() private pure returns (EIP712Storage storage $) {
    assembly {
        $.slot := EIP712StorageLocation
    }
}
```

### _EIP712Name()

- **Kind**: internal
- **Source**: 6170:155:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712Name()`

```solidity
///  @dev The name parameter for the EIP712 domain.
///  NOTE: This function reads from storage by default, but can be redefined to return a constant value if gas costs
///  are a concern.
function _EIP712Name() virtual internal view returns (string memory) {
    EIP712Storage storage $ = _getEIP712Storage();
    return $._name;
}
```

### _EIP712Version()

- **Kind**: internal
- **Source**: 6552:161:37
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol:EIP712Upgradeable:_EIP712Version()`

```solidity
///  @dev The version parameter for the EIP712 domain.
///  NOTE: This function reads from storage by default, but can be redefined to return a constant value if gas costs
///  are a concern.
function _EIP712Version() virtual internal view returns (string memory) {
    EIP712Storage storage $ = _getEIP712Storage();
    return $._version;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EIP712Upgradeable.eip712Domain() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Name() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: EIP712Upgradeable._EIP712Version() (NodeID: 4)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EIP712Upgradeable._getEIP712Storage() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC5267

### Interface Documentation

 @dev returns the fields and values that describe the domain separator used by this contract for EIP-712
 signature.
