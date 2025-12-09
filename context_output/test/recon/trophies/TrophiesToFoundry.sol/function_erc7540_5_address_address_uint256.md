# Function: erc7540_5(address,address,uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_5(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 7838:739:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-5	requestRedeem reverts if the share balance is less than amount
function erc7540_5(address erc7540Target, address shareToken, uint256 shares) virtual public returns (bool) {
    if (shares == 0) {
        return true;
    }
    uint256 actualBal = IShareLike(shareToken).balanceOf(actor);
    uint256 balWeWillUse = actualBal + shares;
    if (balWeWillUse == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).requestRedeem(balWeWillUse, actor, actor, "") {
        return false;
    } catch {
        return true;
    }
}
```

## External Calls

- **IShareLike::balanceOf(address)**
- **IERC7540Like::requestRedeem(uint256,address,address,bytes)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_5(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev 7540-5	requestRedeem reverts if the share balance is less than amount
