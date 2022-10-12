pragma solidity ^0.8.15;

interface IVoteFactory {
    function isVote(address vote) external returns (bool);

    function allVotes(uint256 index) external returns (address);

    function allVotesLength() external returns (uint256);

    function createVote(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memory memberList,
        address presenter,
        uint256 date
    ) external;

    function getVoteAddress(uint256 date) external returns (address voteAddress);
}
