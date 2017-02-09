pragma solidity ^0.4.0;

import "dapple/test.sol";
import "./proposal-vote-db.sol";

contract UnitTest is Test {

  ProposalVoteDb db;

  function setUp () {
    db = new ProposalVoteDb();




  }

}
