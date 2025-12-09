# Function: setUp()

**Contract**: [test/oracles/FixedPriceOracle.t.sol/contract_FixedPriceOracleTest.md]

## Metadata

- **Contract**: FixedPriceOracleTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 666:416:623

## Implementation

```solidity
function setUp() public {
    owner = address(this);
    fixedPriceOracle = FixedPriceOracle(payable(VmContractHelper621(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/FixedPriceOracle.sol:FixedPriceOracle", _args: encodeArgs594(DeployHelper594.FoundryPpConstructorArgs(INITIAL_UP_PRICE, UP_DECIMALS, owner))})));
}
```

## External Calls

- **VmContractHelper621::deployCode(string,bytes)**

## State Variable Reads

- **INITIAL_UP_PRICE** (`int256`)
- **UP_DECIMALS** (`uint8`)
- **owner** (`address`)

## State Variable Writes

- **owner** (`address`)
- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracleTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
