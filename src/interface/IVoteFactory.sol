pragma solidity ^0.8.15;

interface IVoteFactory {
    function createVote(
        uint256 _totalAudience,
        uint256 _rewardPresenter,
        uint256 _rewardAudience,
        address[] memory _memberList,
        address _presenter
    ) external returns (address voteAddress);
}
