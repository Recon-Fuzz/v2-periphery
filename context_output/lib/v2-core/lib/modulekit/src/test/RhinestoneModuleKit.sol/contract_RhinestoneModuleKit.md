# Contract: RhinestoneModuleKit

## Metadata

- **Name**: RhinestoneModuleKit
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol
- **Documentation**: @title RhinestoneModuleKit
   @notice A development kit for building and testing smart account modules

## State Variables

### auxiliary (inherited from AuxiliaryFactory)

```solidity
/// @notice Stores the auxiliary contracts.
Auxiliary public auxiliary
```

### _defaultValidator

```solidity
/// @notice The default validator used for testing
MockValidator public _defaultValidator
```

**MockValidator**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

### _defaultSessionValidator

```solidity
/// @notice The default stateless validator used for testing smart sessions
MockStatelessValidator public _defaultSessionValidator
```

**MockStatelessValidator**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

### isInit

```solidity
/// @notice Whether the module kit has been initialized on a specific chain
mapping(uint256 => bool) public isInit
```
