# Solidity Proposal Vote DB

A simple proposal & vote database contract for Ethereum written in Solidity.

Inherits from [DS-Auth](https://github.com/dapphub/ds-auth) and [DS-Base](https://github.com/dapphub/ds-base).

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

Run `dapple pkg install `
