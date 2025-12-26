# Function: domainSeparator()

**Contract**: [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

## Metadata

- **Contract**: ECDSAPPSOracle
- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 3558:103:532

## Implementation

```solidity
/// @inheritdoc IECDSAPPSOracle
function domainSeparator() external view returns (bytes32) {
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
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracle.domainSeparator() (NodeID: 0)
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

@inheritdoc IECDSAPPSOracle

### Interface Documentation

@notice Returns the EIP-712 domain separator for this contract
 @return The domain separator used for signature validation
 @dev The domain separator is derived from:
      - Contract name (set in constructor)
      - Contract version (set in constructor)
      - Chain ID (from block.chainid)
      - Contract address (address(this))
      Off-chain signers MUST use this exact domain separator when creating signatures.
      The domain separator is computed on-demand using EIP-712's _domainSeparatorV4(),
      which handles chain ID changes (e.g., after hard forks).
      See EIP-712 specification: https://eips.ethereum.org/EIPS/eip-712
