pragma solidity ^0.4.0;

import "dapple/test.sol";
import "./proposal-vote-db.sol";

contract UnitTest is Test {

  ProposalVoteDb db;

  function setUp () {
    db = new ProposalVoteDb();
  }

  function testAddProposal() {
    uint eipNum = 5;

    bytes32 propId = 0x01;
    db.addProposal(eipNum, propId);
    assertEq(db.getProposalCount(eipNum), 1);

    bytes32 secondPropId = 0x02;
    db.addProposal(eipNum, secondPropId);
    assertEq(db.getProposalCount(eipNum), 2);

    var (inFavor, against) = db.getVoteTallies(propId);
    assertEq(inFavor, 0);
    assertEq(against, 0);
  }

  function testVoteFor() {
    uint eipNum = 5;
    bytes32 propId = 0x01;
    bytes32 voter = 0x05;

    db.addProposal(eipNum, propId);
    db.setVote(propId, voter, true);

    var (inFavor, against) = db.getVoteTallies(propId);
    assertEq(inFavor, 1);
    assertEq(against, 0);
  }

  function testVoteAgainst() {
    uint eipNum = 5;
    bytes32 propId = 0x01;
    bytes32 voter = 0x05;

    db.addProposal(eipNum, propId);
    db.setVote(propId, voter, false);

    var (inFavor, against) = db.getVoteTallies(propId);
    assertEq(inFavor, 0);
    assertEq(against, 1);
  }

  function testVoteAgainstChange() {
    uint eipNum = 5;
    bytes32 propId = 0x01;
    bytes32 voter = 0x05;

    db.addProposal(eipNum, propId);
    db.setVote(propId, voter, false);
    db.setVote(propId, voter, true);

    var (inFavor, against) = db.getVoteTallies(propId);
    assertEq(inFavor, 1);
    assertEq(against, 0);
  }

  function testVoteForChange() {
    uint eipNum = 5;
    bytes32 propId = 0x01;
    bytes32 voter = 0x05;

    db.addProposal(eipNum, propId);
    db.setVote(propId, voter, true);
    db.setVote(propId, voter, false);

    var (inFavor, against) = db.getVoteTallies(propId);
    assertEq(inFavor, 0);
    assertEq(against, 1);
  }

}
