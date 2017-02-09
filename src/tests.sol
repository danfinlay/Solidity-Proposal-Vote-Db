pragma solidity ^0.4.0;

import "dapple/test.sol";
import "./proposal-address-vote-db.sol";

contract UnitTest is Test {

  ProposalAddressVoteDb db;

  function setUp () {
    db = new ProposalAddressVoteDb();
  }

}
