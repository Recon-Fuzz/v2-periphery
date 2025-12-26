# Interface: IPermit2Batch

## Metadata

- **Name**: IPermit2Batch
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/uniswap/permit2/IPermit2Batch.sol

## Public/External Functions

### permit(address,struct IAllowanceTransfer.PermitBatch,bytes)

- **Signature**: `permit(address,struct IAllowanceTransfer.PermitBatch,bytes)`
- **Visibility**: external
- **Source Range**: 158:153:476

**Signature:**
```solidity
function permit(address owner, IAllowanceTransfer.PermitBatch memory permitBatch, bytes memory signature) external;;
```

### transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[])

- **Signature**: `transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[])`
- **Visibility**: external
- **Source Range**: 316:103:476

**Signature:**
```solidity
function transferFrom(IAllowanceTransfer.AllowanceTransferDetails[] calldata transferDetails) external;;
```
