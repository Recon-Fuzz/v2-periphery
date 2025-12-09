# Function: deployAccount(struct AccountInstance)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `deployAccount(struct AccountInstance)`
- **Visibility**: public
- **Source Range**: 19133:605:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Deploys an account instance, if it has not been deployed yet
///          reverts if no initCode is provided
///  @param instance AccountInstance the account instance to deploy
function deployAccount(AccountInstance memory instance) virtual public {
    if (instance.account.code.length == 0) {
        if (instance.initCode.length == 0) {
            revert("deployAccount: no initCode provided");
        } else {
            bytes memory initCode = instance.initCode;
            assembly {
                let factory := mload(add(initCode, 20))
                let success := call(gas(), factory, 0, add(initCode, 52), mload(initCode), 0, 0)
                if iszero(success) {
                    revert(0, 0)
                }
            }
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.deployAccount(struct AccountInstance) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Deploys an account instance, if it has not been deployed yet
         reverts if no initCode is provided
 @param instance AccountInstance the account instance to deploy
