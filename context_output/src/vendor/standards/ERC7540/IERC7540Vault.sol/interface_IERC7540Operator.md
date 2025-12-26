# Interface: IERC7540Operator

## Metadata

- **Name**: IERC7540Operator
- **Type**: Interface
- **Path**: src/vendor/standards/ERC7540/IERC7540Vault.sol

## Events

### OperatorSet

```solidity
///  @dev The event emitted when an operator is set.
///  @param controller The address of the controller.
///  @param operator The address of the operator.
///  @param approved The approval status.
event OperatorSet(address indexed controller, address indexed operator, bool approved);
```

## Public/External Functions

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 717:78:540

**Signature:**
```solidity
///  @dev Sets or removes an operator for the caller.
///  @param operator The address of the operator.
///  @param approved The approval status.
///  @return Whether the call was executed successfully or not
function setOperator(address operator, bool approved) external returns (bool);;
```

### isOperator(address,address)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 1067:94:540

**Signature:**
```solidity
///  @dev Returns `true` if the `operator` is approved as an operator for an `controller`.
///  @param controller The address of the controller.
///  @param operator The address of the operator.
///  @return status The approval status
function isOperator(address controller, address operator) external view returns (bool status);;
```
