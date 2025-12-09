# Function: erc7540_3(address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `erc7540_3(address)`
- **Visibility**: public
- **Source Range**: 4062:548:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-3	max* never reverts
function erc7540_3(address erc7540Target) virtual public returns (bool) {
    try IERC7540Like(erc7540Target).maxDeposit(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxMint(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxRedeem(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxWithdraw(actor) {} catch {
        return false;
    }
    return true;
}
```

## External Calls

- **IERC7540Like::maxDeposit(address)**
- **IERC7540Like::maxMint(address)**
- **IERC7540Like::maxRedeem(address)**
- **IERC7540Like::maxWithdraw(address)**

## State Variable Reads

- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_3(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev 7540-3	max* never reverts
