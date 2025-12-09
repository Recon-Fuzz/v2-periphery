# Function: erc7540_7_redeem(address,uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_7_redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 10949:538:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
function erc7540_7_redeem(address erc7540Target, uint256 amt) virtual public returns (bool) {
    uint256 maxRedeem = IERC7540Like(erc7540Target).maxRedeem(actor);
    amt = between(amt, 0, maxRedeem);
    if (amt == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).redeem(amt, actor, actor) {
        return true;
    } catch {
        return false;
    }
}
```

## Related Implementations

### between(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 933:269:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:between(uint256,uint256,uint256)`

```solidity
function between(uint256 value, uint256 low, uint256 high) virtual override internal returns (uint256) {
    if ((value < low) || (value > high)) {
        uint256 ans = low + (value % ((high - low) + 1));
        return ans;
    }
    return value;
}
```

## External Calls

- **IERC7540Like::maxRedeem(address)**
- **IERC7540Like::redeem(uint256,address,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_7_redeem(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [amt, 0, maxRedeem]
      👁️  Def: internal
```
