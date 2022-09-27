pragma solidity ^0.8.15;

import "./interface/IVote.sol";

contract Vote is IVote {
    event VoteStart(uint256 _timestamp);

    event VoteResult(uint256 _timestamp, uint256 _totalAudience, uint256 _approvedAudience, State _result);

    constructor() {}

    function voteAudience(address _audience) external returns (bool result);

    function voteResult() external view returns (VoteState memory voteState);
}
