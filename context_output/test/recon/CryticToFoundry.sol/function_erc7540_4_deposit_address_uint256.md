# Function: erc7540_4_deposit(address,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `erc7540_4_deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 4702:802:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-4 claiming more than max always reverts
function erc7540_4_deposit(address erc7540Target, uint256 amt) virtual public returns (bool) {
    if (amt == 0) {
        return true;
    }
    uint256 maxDep = IERC7540Like(erc7540Target).maxDeposit(actor);
    /// @custom:audit No Revert is proven by erc7540_5
    uint256 sum = maxDep + amt;
    if (sum == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).deposit(maxDep + amt, actor) {
        return false;
    } catch {
        return true;
    }
}
```

## External Calls

- **IERC7540Like::maxDeposit(address)**
- **IERC7540Like::deposit(uint256,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_4_deposit(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev 7540-4 claiming more than max always reverts
