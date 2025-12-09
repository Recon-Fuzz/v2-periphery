# Function: test_FixedPriceOracle_TransferOwnership_RevertNonOwner()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_TransferOwnership_RevertNonOwner()`
- **Visibility**: public
- **Source Range**: 8493:288:623

## Implementation

```solidity
/// @notice Test that non-owner cannot transfer ownership
function test_FixedPriceOracle_TransferOwnership_RevertNonOwner() public {
    address nonOwner = makeAddr("nonOwner");
    address newOwner = makeAddr("newOwner");
    vm.prank(nonOwner);
    vm.expectRevert();
    fixedPriceOracle.transferOwnership(newOwner);
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert()**
- **FixedPriceOracle::transferOwnership(address)**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_TransferOwnership_RevertNonOwner() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["nonOwner"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
      💬 Args: ["newOwner"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test that non-owner cannot transfer ownership
