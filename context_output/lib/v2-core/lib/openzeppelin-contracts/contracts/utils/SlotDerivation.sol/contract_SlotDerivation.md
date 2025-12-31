# Contract: SlotDerivation

## Metadata

- **Name**: SlotDerivation
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/SlotDerivation.sol
- **Documentation**:  @dev Library for computing storage (and transient storage) locations from namespaces and deriving slots
   corresponding to standard patterns. The derivation method for array and mapping matches the storage layout used by
   the solidity language / compiler.
   See https://docs.soliditylang.org/en/v0.8.20/internals/layout_in_storage.html#mappings-and-dynamic-arrays[Solidity docs for mappings and dynamic arrays.].
   Example usage:
   ```solidity
   contract Example {
       // Add the library methods
       using StorageSlot for bytes32;
       using SlotDerivation for bytes32;
       // Declare a namespace
       string private constant _NAMESPACE = "<namespace>"; // eg. OpenZeppelin.Slot
       function setValueInNamespace(uint256 key, address newValue) internal {
           _NAMESPACE.erc7201Slot().deriveMapping(key).getAddressSlot().value = newValue;
       }
       function getValueInNamespace(uint256 key) internal view returns (address) {
           return _NAMESPACE.erc7201Slot().deriveMapping(key).getAddressSlot().value;
       }
   }
   ```
   TIP: Consider using this library along with {StorageSlot}.
   NOTE: This library provides a way to manipulate storage locations in a non-standard way. Tooling for checking
   upgrade safety will ignore the slots accessed through this library.
   _Available since v5.1._
