# Function: erc7540_4_withdraw(address,uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_4_withdraw(address,uint256)`
- **Visibility**: public
- **Source Range**: 6241:738:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
function erc7540_4_withdraw(address erc7540Target, uint256 amt) virtual public returns (bool) {
    if (amt == 0) {
        return true;
    }
    uint256 maxDep = IERC7540Like(erc7540Target).maxWithdraw(actor);
    uint256 sum = maxDep + amt;
    if (sum == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).withdraw(maxDep + amt, actor, actor) {
        return false;
    } catch {
        return true;
    }
}
```

## External Calls

- **IERC7540Like::maxWithdraw(address)**
- **IERC7540Like::withdraw(uint256,address,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_4_withdraw(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
