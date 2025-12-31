# Contract: Create2

## Metadata

- **Name**: Create2
- **Type**: Contract
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Create2.sol
- **Documentation**:  @dev Helper to make usage of the `CREATE2` EVM opcode easier and safer.
   `CREATE2` can be used to compute in advance the address where a smart
   contract will be deployed, which allows for interesting new mechanisms known
   as 'counterfactual interactions'.
   See the https://eips.ethereum.org/EIPS/eip-1014#motivation[EIP] for more
   information.

## Errors

### Create2EmptyBytecode

```solidity
///  @dev There's no code to deploy.
error Create2EmptyBytecode();
```
