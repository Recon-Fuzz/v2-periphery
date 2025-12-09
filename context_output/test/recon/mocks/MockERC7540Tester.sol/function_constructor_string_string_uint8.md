# Function: constructor(string,string,uint8)

**Contract**: [test/recon/mocks/MockERC7540Tester.sol/contract_MockERC7540Tester.md]

## Metadata

- **Contract**: MockERC7540Tester
- **Signature**: `constructor(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 8072:108:73
- **Inherited From**: MockERC20

## Implementation

```solidity
constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name,_symbol,_decimals) {}
```

## Related Implementations

### (string,string,uint8)

- **Kind**: internal
- **Source**: 2622:262:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:constructor(string,string,uint8)`

```solidity
constructor(string memory _name, string memory _symbol, uint8 _decimals) {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    INITIAL_CHAIN_ID = block.chainid;
    INITIAL_DOMAIN_SEPARATOR = computeDomainSeparator();
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

- **name** (`string`)

## State Variable Writes

- **name** (`string`)
- **symbol** (`string`)
- **decimals** (`uint8`)
- **INITIAL_CHAIN_ID** (`uint256`)
- **INITIAL_DOMAIN_SEPARATOR** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockERC20.constructor(string,string,uint8) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockERC20
  └─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string,uint8) (NodeID: 1)
      💬 Args: [_name, _symbol, _decimals]
      🏗️  Contract: ERC20
    └─ [2] ⚙️ FUNCTION: ERC20.computeDomainSeparator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
