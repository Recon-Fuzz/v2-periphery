# Function: test_FixedPriceOracle_TransferOwnership()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `test_FixedPriceOracle_TransferOwnership()`
- **Visibility**: public
- **Source Range**: 7721:704:623

## Implementation

```solidity
/// @notice Test ownership transfer
function test_FixedPriceOracle_TransferOwnership() public {
    address newOwner = makeAddr("newOwner");
    assertEq(fixedPriceOracle.owner(), owner);
    fixedPriceOracle.transferOwnership(newOwner);
    assertEq(fixedPriceOracle.owner(), newOwner);
    vm.expectRevert();
    fixedPriceOracle.setPrice(0.15e18);
    vm.prank(newOwner);
    fixedPriceOracle.setPrice(0.15e18);
    (, int256 answer, , , ) = fixedPriceOracle.latestRoundData();
    assertEq(answer, 0.15e18);
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

### assertEq(address,address)

- **Kind**: internal
- **Source**: 4020:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **FixedPriceOracle::owner()**
- **FixedPriceOracle::transferOwnership(address)**
- **Vm::expectRevert()**
- **FixedPriceOracle::setPrice(int256)**
- **Vm::prank(address)**
- **FixedPriceOracle::latestRoundData()**

## State Variable Reads

- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **owner** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.test_FixedPriceOracle_TransferOwnership() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["newOwner"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 3)
  │   💬 Args: [fixedPriceOracle.owner(), owner]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 4)
  │   💬 Args: [fixedPriceOracle.owner(), newOwner]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 5)
      💬 Args: [answer, 0.15e18]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test ownership transfer
