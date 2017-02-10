pragma solidity ^0.4.0;

import "ds-auth/DSAuth.sol";
import "ds-base/base.sol";

contract ProposalVoteDb is DSAuth, DSBase {

  struct Vote {
    bool hasVoted;
    bool position;
  }

  struct Proposal {
    uint eip;     // eip reference
    mapping (bytes32 => Vote) votes; // map devcon 2 token ID to vote
    uint inFavor; // tally
    uint against; // tally
  }

  // Mapping eip number to proposal arrays
  mapping (uint => string[]) eipIndex;

  // Mapping proposal ID to proposal struct
  mapping (string => Proposal) proposals;

  function addProposal (uint _eip, string _proposalId) auth {
    eipIndex[_eip].push(_proposalId);

    Proposal memory _proposal = Proposal({
      eip: _eip,
      inFavor: 0,
      against: 0
    });

    proposals[_proposalId] = _proposal;
  }

  function getProposalCount (uint _eip) returns (uint) {
    return eipIndex[_eip].length;
  }

  function getVoteTallies (string _proposalId) returns (uint, uint) {
    Proposal memory _proposal = proposals[_proposalId];
    return (_proposal.inFavor _proposal.against);
  }

  function setVote (string _proposal, bytes32 _voter, bool _position) auth {
    Proposal proposal = proposals[_proposal];
    Vote _vote = proposal.votes[_voter];

    if (_vote.hasVoted && _vote.position != _position) { // Modify existing vote

      if (_vote.position) { // If they switched to in favor from against:
        if(safeToSub(proposal.inFavor, 1) && safeToAdd(proposal.against, 1)) {
          proposal.inFavor -= 1;
          proposal.against += 1;
        }

      } else { // If they switched to against to in favor:
        if(safeToAdd(proposal.inFavor, 1) && safeToSub(proposal.against, 1)) {
          proposal.inFavor += 1;
          proposal.against -= 1;
        }
      }

      _vote.position = _position;


    } else { // Create new vote
      if (_position) { // If they were in favor of the proposal:
        if(safeToAdd(proposal.inFavor, 1)) {
          proposal.inFavor += 1;
        }

      } else { // If they were against this proposal:
        if (safeToAdd(proposal.against, 1)) {
          proposal.against += 1;
        }
      }

      proposal.votes[_voter] = Vote({
        hasVoted: true,
        position: _position
      });
    }

  }

  function getVote (string _proposal, bytes32 _voter) returns (bool) {
    Vote _vote = proposals[_proposal].votes[_voter];
    if (!_vote.hasVoted) {
      throw;
    }
    return _vote.position;
  }

}
