# Function: DOMAIN_SEPARATOR()

**Contract**: [test/mocks/MockUp.sol/contract_MockUp.md]

## Metadata

- **Contract**: MockUp
- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 2614:112:269
- **Inherited From**: ERC20Permit

## Implementation

```solidity
/// @inheritdoc IERC20Permit
function DOMAIN_SEPARATOR() virtual external view returns (bytes32) {
    return _domainSeparatorV4();
}
```

## Related Implementations

### _domainSeparatorV4()

- **Kind**: internal
- **Source**: 3945:262:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_domainSeparatorV4()`

```solidity
///  @dev Returns the domain separator for the current chain.
function _domainSeparatorV4() internal view returns (bytes32) {
    if ((address(this) == _cachedThis) && (block.chainid == _cachedChainId)) {
        return _cachedDomainSeparator;
    } else {
        return _buildDomainSeparator();
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 4213:179:288
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
}
```

## State Variable Reads

- **_cachedThis** (`address`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Permit.DOMAIN_SEPARATOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EIP712._domainSeparatorV4() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC20Permit

### Interface Documentation

 @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
