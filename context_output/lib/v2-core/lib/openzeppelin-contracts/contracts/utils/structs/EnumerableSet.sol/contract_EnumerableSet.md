# Contract: EnumerableSet

## Metadata

- **Name**: EnumerableSet
- **Type**: Contract
- **Path**: lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol
- **Documentation**:  @dev Library for managing
   https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
   types.
   Sets have the following properties:
   - Elements are added, removed, and checked for existence in constant time
   (O(1)).
   - Elements are enumerated in O(n). No guarantees are made on the ordering.
   - Set can be cleared (all elements removed) in O(n).
   ```solidity
   contract Example {
       // Add the library methods
       using EnumerableSet for EnumerableSet.AddressSet;
       // Declare a set state variable
       EnumerableSet.AddressSet private mySet;
   }
   ```
   The following types are supported:
   - `bytes32` (`Bytes32Set`) since v3.3.0
   - `address` (`AddressSet`) since v3.3.0
   - `uint256` (`UintSet`) since v3.3.0
   - `string` (`StringSet`) since v5.4.0
   - `bytes` (`BytesSet`) since v5.4.0
   [WARNING]
   ====
   Trying to delete such a structure from storage will likely result in data corruption, rendering the structure
   unusable.
   See https://github.com/ethereum/solidity/pull/11843[ethereum/solidity#11843] for more info.
   In order to clean an EnumerableSet, you can either remove all elements one by one or create a fresh instance using an
   array of EnumerableSet.
   ====

## Structs

### Set

```solidity
struct Set {
    bytes32[] _values;
    mapping(bytes32 => uint256) _positions;
}
```

### Bytes32Set

```solidity
struct Bytes32Set {
    Set _inner;
}
```

### AddressSet

```solidity
struct AddressSet {
    Set _inner;
}
```

### UintSet

```solidity
struct UintSet {
    Set _inner;
}
```

### StringSet

```solidity
struct StringSet {
    string[] _values;
    mapping(string => uint256) _positions;
}
```

### BytesSet

```solidity
struct BytesSet {
    bytes[] _values;
    mapping(bytes => uint256) _positions;
}
```
