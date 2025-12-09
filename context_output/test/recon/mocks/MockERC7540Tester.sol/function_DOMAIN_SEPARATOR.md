# Function: DOMAIN_SEPARATOR()

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 6300:177:73
- **Inherited From**: ERC20

## Implementation

```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32) {
    return (block.chainid == INITIAL_CHAIN_ID) ? INITIAL_DOMAIN_SEPARATOR : computeDomainSeparator();
}
```

## Related Implementations

### computeDomainSeparator()

- **Kind**: internal
- **Source**: 6483:402:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:computeDomainSeparator()`

```solidity
function computeDomainSeparator() virtual internal view returns (bytes32) {
    return keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"), keccak256(bytes(name)), keccak256("1"), block.chainid, address(this)));
}
```

## State Variable Reads

- **INITIAL_CHAIN_ID** (`uint256`)
- **INITIAL_DOMAIN_SEPARATOR** (`bytes32`)
- **name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.DOMAIN_SEPARATOR() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.computeDomainSeparator() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
