# Contract: StorageSlot

## Metadata

- **Name**: StorageSlot
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol
- **Documentation**:  @dev Library for reading and writing primitive types to specific storage slots.
   Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
   This library helps with reading and writing to such slots without the need for inline assembly.
   The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
   Example usage to set ERC-1967 implementation slot:
   ```solidity
   contract ERC1967 {
       // Define the slot. Alternatively, use the SlotDerivation library to derive the slot.
       bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
       function _getImplementation() internal view returns (address) {
           return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
       }
       function _setImplementation(address newImplementation) internal {
           require(newImplementation.code.length > 0);
           StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
       }
   }
   ```
   TIP: Consider using this library along with {SlotDerivation}.

## Structs

### AddressSlot

```solidity
struct AddressSlot {
    address value;
}
```

### BooleanSlot

```solidity
struct BooleanSlot {
    bool value;
}
```

### Bytes32Slot

```solidity
struct Bytes32Slot {
    bytes32 value;
}
```

### Uint256Slot

```solidity
struct Uint256Slot {
    uint256 value;
}
```

### Int256Slot

```solidity
struct Int256Slot {
    int256 value;
}
```

### StringSlot

```solidity
struct StringSlot {
    string value;
}
```

### BytesSlot

```solidity
struct BytesSlot {
    bytes value;
}
```
