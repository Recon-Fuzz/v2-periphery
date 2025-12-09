# Function: permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 4853:1441:73
- **Inherited From**: ERC20

## Implementation

```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public {
    require(deadline >= block.timestamp, "PERMIT_DEADLINE_EXPIRED");
    unchecked {
        address recoveredAddress = ecrecover(keccak256(abi.encodePacked("\u0019\u0001", DOMAIN_SEPARATOR(), keccak256(abi.encode(keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), owner, spender, value, nonces[owner]++, deadline)))), v, r, s);
        require((recoveredAddress != address(0)) && (recoveredAddress == owner), "INVALID_SIGNER");
        allowance[recoveredAddress][spender] = value;
    }
    emit Approval(owner, spender, value);
}
```

## Related Implementations

### DOMAIN_SEPARATOR()

- **Kind**: internal
- **Source**: 6300:177:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:DOMAIN_SEPARATOR()`

```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32) {
    return (block.chainid == INITIAL_CHAIN_ID) ? INITIAL_DOMAIN_SEPARATOR : computeDomainSeparator();
}
```

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

## State Variable Writes

- **nonces** (`mapping(address => uint256)`)
- **allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.DOMAIN_SEPARATOR() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC20.computeDomainSeparator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
