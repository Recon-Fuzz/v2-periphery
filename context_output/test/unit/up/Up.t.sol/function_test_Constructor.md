# Function: test_Constructor()

**Contract**: [test/unit/up/Up.t.sol/contract_UpTest.md]

## Metadata

- **Contract**: UpTest
- **Signature**: `test_Constructor()`
- **Visibility**: public
- **Source Range**: 1768:359:663

## Implementation

```solidity
///  Constructor Tests
function test_Constructor() public view {
    assertEq(UpToken.name(), "Superform");
    assertEq(UpToken.symbol(), "UP");
    assertEq(UpToken.totalSupply(), INITIAL_SUPPLY);
    assertEq(UpToken.balanceOf(owner), INITIAL_SUPPLY);
    assertEq(UpToken.owner(), owner);
    assertEq(UpToken.lastMintTimestamp(), block.timestamp);
}
```

## Related Implementations

### assertEq(string,string)

- **Kind**: internal
- **Source**: 5050:122:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(string,string)`

```solidity
function assertEq(string memory left, string memory right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
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

## External Calls

- **Up::name()**
- **Up::symbol()**
- **Up::totalSupply()**
- **Up::balanceOf(address)**
- **Up::owner()**
- **Up::lastMintTimestamp()**

## State Variable Reads

- **UpToken** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **INITIAL_SUPPLY** (`uint256`)
- **owner** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpTest.test_Constructor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 1)
  │   💬 Args: [UpToken.name(), "Superform"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(string,string) (NodeID: 2)
  │   💬 Args: [UpToken.symbol(), "UP"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [UpToken.totalSupply(), INITIAL_SUPPLY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [UpToken.balanceOf(owner), INITIAL_SUPPLY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 5)
  │   💬 Args: [UpToken.owner(), owner]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [UpToken.lastMintTimestamp(), block.timestamp]
      👁️  Def: internal
```

## Documentation

### Function Documentation

 Constructor Tests
