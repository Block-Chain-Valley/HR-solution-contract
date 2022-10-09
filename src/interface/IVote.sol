pragma solidity ^0.8.15;

interface IVote {
    enum State {
        Ongoing,
        Approved,
        Rejected
    }

    struct VoteState {
        State _state;
        uint256 _totalAudience;
        uint256 _approvedAudience;
        uint256 _startTime;
        uint256 _endTime;
        uint256 _rewardPresenter;
        uint256 _rewardAudience;
        address[] _memberList;
        address _presenter;
    }

    // event VoteStart(uint256 _timestamp);

    // event VoteResult(uint256 _timestamp, uint256 _totalAudience, uint256 _approvedAudience, State _result);

    function initialize(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memberList,
        address presenter
    ) external;

    // function voteAudience(address) external returns (bool);

    function voteResult() external view returns (VoteState memory);
}
