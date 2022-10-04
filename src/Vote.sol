pragma solidity ^0.8.15;

import "./interface/IVote.sol";

contract Vote is IVote {
    function initialize(
        uint256 _totalAudience,
        uint256 _rewardPresenter,
        uint256 _rewardAudience,
        address[] _audience
    ) external {}

    function voteAudience(address _audience) external returns (bool result) {}

    function voteResult() external view returns (VoteState memory voteState) {}
}
