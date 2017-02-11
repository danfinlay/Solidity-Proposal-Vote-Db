# Solidity Proposal Vote DB

A simple proposal & vote database contract for Ethereum written in Solidity.

Inherits from [DS-Auth](https://github.com/dapphub/ds-auth) and [DS-Base](https://github.com/dapphub/ds-base).

Should be used by a frontend contract that is set as the database's owner, as defined by DS-Auth, allowing for easily updating frontend logic while keeping a consistent vote tally db.

Solidity Interface:

```
contract ProposalVoteDb is DSAuth, DSBase {

  function addProposal (uint _eip, bytes32 _proposalId);
  function getProposalCount (uint _eip) returns (uint);
  function setVote (bytes32 _proposal, bytes32 _voter, bool _position);
  function getVote (bytes32 _proposal, bytes32 _voter) returns (bool);
  function getVoteTallies (bytes32 _proposalId) returns (uint, uint);

}
```

[JSON ABI](./abi.json)

## Installation

Install [Dapple](https://www.npmjs.com/package/dapple) with `npm install dapple -g`.

Your project may need to be a Dapple project to install in this manner, but we will add a proper ethpm module eventually.

In your project folder:
```
dapple init
```

Run `dapple pkg install ipfs://QmPNzXp2NGj1DFdinTrWNYKBgRas12hoVtbwZMxgPXWRMF`

Import the file into our solidity files:

```
import "sol-proposal-address-vote-db/proposal-vote-db.sol";
```

