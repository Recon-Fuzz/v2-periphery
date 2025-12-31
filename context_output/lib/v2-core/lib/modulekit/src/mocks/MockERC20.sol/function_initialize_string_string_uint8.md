# Function: initialize(string,string,uint8)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `initialize(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 2530:365:196

## Implementation

```solidity
/// @dev To hide constructor warnings across solc versions due to different constructor
///  visibility requirements and
///  syntaxes, we add an initialization function that can be called only once.
function initialize(string memory name_, string memory symbol_, uint8 decimals_) public {
    require(!initialized, "ALREADY_INITIALIZED");
    _name = name_;
    _symbol = symbol_;
    _decimals = decimals_;
    INITIAL_CHAIN_ID = _pureChainId();
    INITIAL_DOMAIN_SEPARATOR = computeDomainSeparator();
    initialized = true;
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

- **initialized** (`bool`)
- **_name** (`string`)

## State Variable Writes

- **_name** (`string`)
- **_symbol** (`string`)
- **_decimals** (`uint8`)
- **INITIAL_CHAIN_ID** (`uint256`)
- **INITIAL_DOMAIN_SEPARATOR** (`bytes32`)
- **initialized** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.initialize(string,string,uint8) (NodeID: 0)
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

## Documentation

### Function Documentation

@dev To hide constructor warnings across solc versions due to different constructor
 visibility requirements and
 syntaxes, we add an initialization function that can be called only once.
