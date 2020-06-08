# Solidity Unordered Key Set
Library that implements a Solidity CRUD (Create, Read, Update, Delete) pattern.  
Based on [Rob Hitchens UnorderedKeySet](https://github.com/rob-Hitchens/UnorderedKeySet) with minor changes/improvements:
- Use [safeMath](https://docs.openzeppelin.com/contracts/3.x/api/math#SafeMath) for arithmetic operations
- Rename `count` function into `remove`
- Rename `nukeSet` function into `nuke`
- Add `indexAtKey` function
- Add tests (written in solidity)

## Development
### Requirement: [dapp.tools](https://dapp.tools/)
### Compile contracts: `dapp --use solc:0.6.0 build`
### Test contracts: `dapp --use solc:0.6.0 test`

## Credit
[Rob Hitchens](https://github.com/rob-Hitchens/UnorderedKeySet)
