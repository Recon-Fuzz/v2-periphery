# Function: erc7540_7_deposit(address,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `erc7540_7_deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 9292:564:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-7 if max[method] > 0, then [method] (max) should not revert
function erc7540_7_deposit(address erc7540Target, uint256 amt) virtual public returns (bool) {
    uint256 maxDeposit = IERC7540Like(erc7540Target).maxDeposit(actor);
    amt = between(amt, 0, maxDeposit);
    if (amt == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).deposit(amt, actor) {
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

- **IERC7540Like::maxDeposit(address)**
- **IERC7540Like::deposit(uint256,address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_7_deposit(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [amt, 0, maxDeposit]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev 7540-7 if max[method] > 0, then [method] (max) should not revert
