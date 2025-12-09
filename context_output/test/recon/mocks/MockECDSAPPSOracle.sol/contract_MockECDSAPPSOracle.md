# Contract: MockECDSAPPSOracle

## Metadata

- **Name**: MockECDSAPPSOracle
- **Type**: Contract
- **Path**: test/recon/mocks/MockECDSAPPSOracle.sol

## State Variables

### _SUPER_GOVERNORReturn_0

```solidity
address private _SUPER_GOVERNORReturn_0
```

### _UPDATE_PPS_TYPEHASHReturn_0

```solidity
bytes32 private _UPDATE_PPS_TYPEHASHReturn_0
```

### _domainSeparatorReturn_0

```solidity
bytes32 private _domainSeparatorReturn_0
```

### _eip712DomainReturn_0

```solidity
bytes1 private _eip712DomainReturn_0
```

### _eip712DomainReturn_1

```solidity
string private _eip712DomainReturn_1
```

### _eip712DomainReturn_2

```solidity
string private _eip712DomainReturn_2
```

### _eip712DomainReturn_3

```solidity
uint256 private _eip712DomainReturn_3
```

### _eip712DomainReturn_4

```solidity
address private _eip712DomainReturn_4
```

### _eip712DomainReturn_5

```solidity
bytes32 private _eip712DomainReturn_5
```

### _eip712DomainReturn_6

```solidity
uint256[] private _eip712DomainReturn_6
```

### _nonceReturn_0

```solidity
uint256 private _nonceReturn_0
```

## Events

### EIP712DomainChanged

```solidity
///    ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️  *
///  -----------------------------------------------------------------*
///       Generally you only need to modify the sections above.      *
///           The code below handles system operations.              *
event EIP712DomainChanged();
```

### PPSValidated

```solidity
event PPSValidated(address strategy, uint256 pps, uint256 ppsStdev, uint256 validatorSet, uint256 totalValidators, uint256 timestamp, address sender);
```

## Public/External Functions

### updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)

- **Signature**: `updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)`
- **Visibility**: public
- **Source Range**: 669:389:636
- **Details**: [function_updatePPS_struct_IECDSAPPSOracle.UpdatePPSArgs.md](./function_updatePPS_struct_IECDSAPPSOracle.UpdatePPSArgs.md)

**Signature:**
```solidity
function updatePPS(IECDSAPPSOracle.UpdatePPSArgs memory args) public;
```

### setSUPER_GOVERNORReturn(address)

- **Signature**: `setSUPER_GOVERNORReturn(address)`
- **Visibility**: public
- **Source Range**: 1959:107:636
- **Details**: [function_setSUPER_GOVERNORReturn_address.md](./function_setSUPER_GOVERNORReturn_address.md)

**Signature:**
```solidity
function setSUPER_GOVERNORReturn(address _value0) public;
```

### setUPDATE_PPS_TYPEHASHReturn(bytes32)

- **Signature**: `setUPDATE_PPS_TYPEHASHReturn(bytes32)`
- **Visibility**: public
- **Source Range**: 2133:117:636
- **Details**: [function_setUPDATE_PPS_TYPEHASHReturn_bytes32.md](./function_setUPDATE_PPS_TYPEHASHReturn_bytes32.md)

**Signature:**
```solidity
function setUPDATE_PPS_TYPEHASHReturn(bytes32 _value0) public;
```

### setDomainSeparatorReturn(bytes32)

- **Signature**: `setDomainSeparatorReturn(bytes32)`
- **Visibility**: public
- **Source Range**: 2313:109:636
- **Details**: [function_setDomainSeparatorReturn_bytes32.md](./function_setDomainSeparatorReturn_bytes32.md)

**Signature:**
```solidity
function setDomainSeparatorReturn(bytes32 _value0) public;
```

### SUPER_GOVERNOR()

- **Signature**: `SUPER_GOVERNOR()`
- **Visibility**: public
- **Source Range**: 5102:103:636
- **Details**: [function_SUPER_GOVERNOR.md](./function_SUPER_GOVERNOR.md)

**Signature:**
```solidity
function SUPER_GOVERNOR() public view returns (address);
```

### UPDATE_PPS_TYPEHASH()

- **Signature**: `UPDATE_PPS_TYPEHASH()`
- **Visibility**: public
- **Source Range**: 5261:113:636
- **Details**: [function_UPDATE_PPS_TYPEHASH.md](./function_UPDATE_PPS_TYPEHASH.md)

**Signature:**
```solidity
function UPDATE_PPS_TYPEHASH() public view returns (bytes32);
```

### domainSeparator()

- **Signature**: `domainSeparator()`
- **Visibility**: public
- **Source Range**: 5426:105:636
- **Details**: [function_domainSeparator.md](./function_domainSeparator.md)

**Signature:**
```solidity
function domainSeparator() public view returns (bytes32);
```

### eip712Domain()

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5580:435:636
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
function eip712Domain() public view returns (bytes1, string memory, string memory, uint256, address, bytes32, uint256[] memory);
```

### nonce()

- **Signature**: `nonce()`
- **Visibility**: public
- **Source Range**: 6057:85:636
- **Details**: [function_nonce.md](./function_nonce.md)

**Signature:**
```solidity
function nonce() public view returns (uint256);
```
