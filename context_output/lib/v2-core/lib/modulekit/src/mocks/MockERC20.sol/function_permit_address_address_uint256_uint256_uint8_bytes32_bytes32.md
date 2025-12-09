# Function: permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 4331:1244:196

## Implementation

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public {
    require(deadline >= block.timestamp, "PERMIT_DEADLINE_EXPIRED");
    address recoveredAddress = ecrecover(keccak256(abi.encodePacked("\u0019\u0001", DOMAIN_SEPARATOR(), keccak256(abi.encode(keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), owner, spender, value, nonces[owner]++, deadline)))), v, r, s);
    require((recoveredAddress != address(0)) && (recoveredAddress == owner), "INVALID_SIGNER");
    _allowance[recoveredAddress][spender] = value;
    emit Approval(owner, spender, value);
}
```

## Related Implementations

### DOMAIN_SEPARATOR()

- **Kind**: internal
- **Source**: 5581:190:196
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol:MockERC20:DOMAIN_SEPARATOR()`

```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32) {
    return (_pureChainId() == INITIAL_CHAIN_ID) ? INITIAL_DOMAIN_SEPARATOR : computeDomainSeparator();
}
```

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

## State Variable Writes

- **nonces** (`mapping(address => uint256)`)
- **_allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MockERC20.DOMAIN_SEPARATOR() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: MockERC20._pureChainId() (NodeID: 2)
    │   💬 Args: [no args]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: MockERC20.computeDomainSeparator() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: MockERC20._pureChainId() (NodeID: 4)
          💬 Args: [no args]
          👁️  Def: private
```
