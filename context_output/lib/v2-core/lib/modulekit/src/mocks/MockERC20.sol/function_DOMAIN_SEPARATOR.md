# Function: DOMAIN_SEPARATOR()

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 5581:190:196

## Implementation

```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32) {
    return (_pureChainId() == INITIAL_CHAIN_ID) ? INITIAL_DOMAIN_SEPARATOR : computeDomainSeparator();
}
```

## Related Implementations

### _pureChainId()

- **Kind**: internal
- **Source**: 8221:300:196
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol:MockERC20:_pureChainId()`

```solidity
function _pureChainId() private pure returns (uint256 chainId) {
    function() internal view returns (uint256) fnIn = _viewChainId;
    function() internal pure returns (uint256) pureChainId;
    assembly {
        pureChainId := fnIn
    }
    chainId = pureChainId();
}
```

### computeDomainSeparator()

- **Kind**: internal
- **Source**: 5777:442:196
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol:MockERC20:computeDomainSeparator()`

```solidity
function computeDomainSeparator() virtual internal view returns (bytes32) {
    return keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"), keccak256(bytes(_name)), keccak256("1"), _pureChainId(), address(this)));
}
```

## State Variable Reads

- **INITIAL_CHAIN_ID** (`uint256`)
- **INITIAL_DOMAIN_SEPARATOR** (`bytes32`)
- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.DOMAIN_SEPARATOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC20._pureChainId() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: MockERC20.computeDomainSeparator() (NodeID: 2)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MockERC20._pureChainId() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: private
```
