# Function: erc7540_7_mint(address,uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_7_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 9862:524:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
function erc7540_7_mint(address erc7540Target, uint256 amt) virtual public returns (bool) {
    uint256 maxMint = IERC7540Like(erc7540Target).maxMint(actor);
    amt = between(amt, 0, maxMint);
    if (amt == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).mint(amt, actor) {
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

- **IERC7540Like::maxMint(address)**
- **IERC7540Like::mint(uint256,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_7_mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [amt, 0, maxMint]
      👁️  Def: internal
```
