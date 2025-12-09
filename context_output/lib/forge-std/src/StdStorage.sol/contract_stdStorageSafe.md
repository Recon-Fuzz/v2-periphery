# Contract: stdStorageSafe

## Metadata

- **Name**: stdStorageSafe
- **Type**: Contract
- **Path**: lib/forge-std/src/StdStorage.sol

## State Variables

### vm

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

## Events

### SlotFound

```solidity
event SlotFound(address who, bytes4 fsig, bytes32 keysHash, uint256 slot);
```

### WARNING_UninitedSlot

```solidity
event WARNING_UninitedSlot(address who, uint256 slot);
```
