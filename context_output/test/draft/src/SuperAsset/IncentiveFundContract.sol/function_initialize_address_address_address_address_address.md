# Function: initialize(address,address,address,address,address)

**Contract**: [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]

## Metadata

- **Contract**: IncentiveFundContract
- **Signature**: `initialize(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 1939:894:547

## Implementation

```solidity
/// @inheritdoc IIncentiveFundContract
function initialize(address _superGovernor, address _superRegistry, address superAsset_, address tokenInIncentive_, address tokenOutIncentive_) external {
    if ((_superGovernor == address(0)) || (_superRegistry == address(0))) revert ZERO_ADDRESS();
    superGovernor = ISuperGovernor(_superGovernor);
    superRegistry = ISuperRegistry(_superRegistry);
    if (address(superAsset) != address(0)) revert ALREADY_INITIALIZED();
    if (superAsset_ == address(0)) revert ZERO_ADDRESS();
    if (tokenInIncentive_ == address(0)) revert ZERO_ADDRESS();
    if (tokenOutIncentive_ == address(0)) revert ZERO_ADDRESS();
    superAsset = ISuperAsset(superAsset_);
    tokenInIncentive = tokenInIncentive_;
    tokenOutIncentive = tokenOutIncentive_;
}
```

## State Variable Reads

- **superAsset** (`contract ISuperAsset`) [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]

## State Variable Writes

- **superGovernor** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **superAsset** (`contract ISuperAsset`) [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]
- **tokenInIncentive** (`address`)
- **tokenOutIncentive** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveFundContract.initialize(address,address,address,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveFundContract

### Interface Documentation

@notice Initializes the IncentiveFundContract
 @param _superGovernor Address of the SuperGovernor contract
 @param _superRegistry Address of the SuperRegistry contract
 @param superAsset_ Address of the SuperAsset contract
 @param tokenInIncentive_ Address of the token users send incentives to
 @param tokenOutIncentive_ Address of the token used to pay incentives
