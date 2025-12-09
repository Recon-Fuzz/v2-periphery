# Function: constructor(address)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 3112:68:639

## Implementation

```solidity
constructor(address _yieldToken) ERC5115(MockERC20(_yieldToken)) {}
```

## Related Implementations

### (contract MockERC20)

- **Kind**: internal
- **Source**: 638:212:639
- **Link**: `test/recon/mocks/MockERC5115Tester.sol:ERC5115:constructor(contract MockERC20)`

```solidity
constructor(MockERC20 _yieldToken) MockERC20("MockERC5115Tester","SY5115",18) {
    yieldToken = _yieldToken;
    tokensIn.push(address(_yieldToken));
    tokensOut.push(address(_yieldToken));
}
```

### (string,string,uint8)

- **Kind**: internal
- **Source**: 8072:108:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:MockERC20:constructor(string,string,uint8)`

```solidity
constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name,_symbol,_decimals) {}
```

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

- **yieldToken** (`contract MockERC20`) [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]
- **tokensIn** (`address[]`)
- **tokensOut** (`address[]`)
- **name** (`string`)
- **symbol** (`string`)
- **decimals** (`uint8`)
- **INITIAL_CHAIN_ID** (`uint256`)
- **INITIAL_DOMAIN_SEPARATOR** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockERC5115Tester.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockERC5115Tester
  └─ [1] 🏗️ CONSTRUCTOR: ERC5115.constructor(contract MockERC20) (NodeID: 1)
      💬 Args: [MockERC20(_yieldToken)]
      🏗️  Contract: ERC5115
    └─ [2] 🏗️ CONSTRUCTOR: MockERC20.constructor(string,string,uint8) (NodeID: 2)
        💬 Args: ["MockERC5115Tester", "SY5115", 18]
        🏗️  Contract: MockERC20
      └─ [3] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string,uint8) (NodeID: 3)
          💬 Args: ["MockERC5115Tester", "SY5115", 18]
          🏗️  Contract: ERC20
        └─ [4] ⚙️ FUNCTION: ERC20.computeDomainSeparator() (NodeID: 4)
            💬 Args: [no args]
            👁️  Def: internal
```
