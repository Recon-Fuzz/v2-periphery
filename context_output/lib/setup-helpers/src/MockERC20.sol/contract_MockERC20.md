# Contract: MockERC20

## Metadata

- **Name**: MockERC20
- **Type**: Contract
- **Path**: lib/setup-helpers/src/MockERC20.sol

## State Variables

### name (inherited from ERC20)

```solidity
string public name
```

### symbol (inherited from ERC20)

```solidity
string public symbol
```

### decimals (inherited from ERC20)

```solidity
uint8 public immutable decimals
```

### totalSupply (inherited from ERC20)

```solidity
uint256 public totalSupply
```

### balanceOf (inherited from ERC20)

```solidity
mapping(address => uint256) public balanceOf
```

### allowance (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) public allowance
```

### INITIAL_CHAIN_ID (inherited from ERC20)

```solidity
uint256 internal immutable INITIAL_CHAIN_ID
```

### INITIAL_DOMAIN_SEPARATOR (inherited from ERC20)

```solidity
bytes32 internal immutable INITIAL_DOMAIN_SEPARATOR
```

### nonces (inherited from ERC20)

```solidity
mapping(address => uint256) public nonces
```

## Errors

### InsufficientBalance (inherited from ERC20)

```solidity
/// @notice Thrown when attempting to transfer more tokens than available balance
error InsufficientBalance(address from, uint256 balance, uint256 amount);
```

### InsufficientAllowance (inherited from ERC20)

```solidity
/// @notice Thrown when attempting to transfer more tokens than allowed
error InsufficientAllowance(address owner, address spender, uint256 allowance, uint256 amount);
```

### MintOverflow (inherited from ERC20)

```solidity
/// @notice Thrown when minting would cause overflow
error MintOverflow(uint256 currentSupply, uint256 amount);
```

## Events

### Transfer (inherited from ERC20)

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount);
```

### Approval (inherited from ERC20)

```solidity
event Approval(address indexed owner, address indexed spender, uint256 amount);
```

## Public/External Functions

### constructor(string,string,uint8)

- **Signature**: `constructor(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 8072:108:73
- **Details**: [function_constructor_string_string_uint8.md](./function_constructor_string_string_uint8.md)

**Signature:**
```solidity
constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name,_symbol,_decimals);
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 8186:89:73
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
function mint(address to, uint256 value) virtual public;
```

### burn(address,uint256)

- **Signature**: `burn(address,uint256)`
- **Visibility**: public
- **Source Range**: 8281:93:73
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
function burn(address from, uint256 value) virtual public;
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3072:211:73
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 amount) virtual public returns (bool);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3289:535:73
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address to, uint256 amount) virtual public returns (bool);
```

### transferFrom(address,address,uint256) (inherited from ERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3830:834:73
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 amount) virtual public returns (bool);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from ERC20)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 4853:1441:73
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public;
```

### DOMAIN_SEPARATOR() (inherited from ERC20)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 6300:177:73
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32);
```
