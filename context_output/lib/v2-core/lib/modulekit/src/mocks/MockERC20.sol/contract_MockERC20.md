# Contract: MockERC20

## Metadata

- **Name**: MockERC20
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol
- **Documentation**: @notice This is a mock contract of the ERC20 standard for testing purposes only, it SHOULD NOT
   be used in production.
   @dev Forked from:
   https://github.com/transmissions11/solmate/blob/0384dbaaa4fcb5715738a9254a7c0a4cb62cf458/src/tokens/ERC20.sol

## State Variables

### _name

```solidity
string internal _name
```

### _symbol

```solidity
string internal _symbol
```

### _decimals

```solidity
uint8 internal _decimals
```

### _totalSupply

```solidity
uint256 internal _totalSupply
```

### _balanceOf

```solidity
mapping(address => uint256) internal _balanceOf
```

### _allowance

```solidity
mapping(address => mapping(address => uint256)) internal _allowance
```

### INITIAL_CHAIN_ID

```solidity
uint256 internal INITIAL_CHAIN_ID
```

### INITIAL_DOMAIN_SEPARATOR

```solidity
bytes32 internal INITIAL_DOMAIN_SEPARATOR
```

### nonces

```solidity
mapping(address => uint256) public nonces
```

### initialized

```solidity
/// @dev A bool to track whether the contract has been initialized.
bool private initialized
```

## Public/External Functions

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 695:92:196
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() override external view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 793:96:196
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
function symbol() override external view returns (string memory);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 895:92:196
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() override external view returns (uint8);
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 1340:100:196
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
function totalSupply() override external view returns (uint256);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 1446:116:196
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
function balanceOf(address owner) override external view returns (uint256);
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1568:142:196
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
function allowance(address owner, address spender) override external view returns (uint256);
```

### initialize(string,string,uint8)

- **Signature**: `initialize(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 2530:365:196
- **Details**: [function_initialize_string_string_uint8.md](./function_initialize_string_string_uint8.md)

**Signature:**
```solidity
/// @dev To hide constructor warnings across solc versions due to different constructor
///  visibility requirements and
///  syntaxes, we add an initialization function that can be called only once.
function initialize(string memory name_, string memory symbol_, uint8 decimals_) public;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3083:221:196
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 amount) virtual override public returns (bool);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3310:288:196
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address to, uint256 amount) virtual override public returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3604:538:196
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 amount) virtual override public returns (bool);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 4331:1244:196
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public;
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 5581:190:196
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32);
```
