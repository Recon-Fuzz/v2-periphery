# Function: fromHex(string)

**Contract**: [test/integration/SuperVault/BaseSuperVaultTest.t.sol/contract_BaseSuperVaultTest.md]

## Metadata

- **Contract**: BaseSuperVaultTest
- **Signature**: `fromHex(string)`
- **Visibility**: public
- **Source Range**: 373:517:504
- **Inherited From**: BaseAPIParser

## Implementation

```solidity
function fromHex(string memory s) public pure returns (bytes memory) {
    bytes memory ss = bytes(s);
    require(((ss.length >= 2) && (ss[0] == "0")) && ((ss[1] == "x") || (ss[1] == "X")), "BaseAPIParser: hex string must start with 0x");
    bytes memory r = new bytes((ss.length - 2) / 2);
    for (uint256 i = 0; i < r.length; ++i) {
        r[i] = bytes1((_fromHexChar(uint8(ss[(2 * i) + 2])) * 16) + _fromHexChar(uint8(ss[(2 * i) + 3])));
    }
    return r;
}
```

## Related Implementations

### _fromHexChar(uint8)

- **Kind**: internal
- **Source**: 896:485:504
- **Link**: `lib/v2-core/test/utils/parsers/BaseAPIParser.sol:BaseAPIParser:_fromHexChar(uint8)`

```solidity
function _fromHexChar(uint8 c) private pure returns (uint8) {
    if ((c >= uint8(bytes1("0"))) && (c <= uint8(bytes1("9")))) {
        return c - uint8(bytes1("0"));
    }
    if ((c >= uint8(bytes1("a"))) && (c <= uint8(bytes1("f")))) {
        return (10 + c) - uint8(bytes1("a"));
    }
    if ((c >= uint8(bytes1("A"))) && (c <= uint8(bytes1("F")))) {
        return (10 + c) - uint8(bytes1("A"));
    }
    revert("BaseAPIParser: invalid hex char");
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseAPIParser.fromHex(string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseAPIParser._fromHexChar(uint8) (NodeID: 1)
  │   💬 Args: [uint8(ss[(2 * i) + 3])]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: BaseAPIParser._fromHexChar(uint8) (NodeID: 2)
      💬 Args: [uint8(ss[(2 * i) + 2])]
      👁️  Def: private
```
