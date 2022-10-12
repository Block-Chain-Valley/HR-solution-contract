pragma solidity ^0.8.15;

import "./IAttendance.sol";
import "./IVote.sol";

interface IView {
    struct VoteStatus {
        address voteAddr;
        IVote.State state;
        uint256 totalAudience;
        uint256 approvedAudience;
        uint256 startTime;
        uint256 endTime;
        uint256 rewardPresenter;
        uint256 rewardAudience;
        address[] memberList;
        address presenter;
    }

    function getVoteAddress(uint256 date) external returns (address voteContractAddress);

    function getAttendanceAddress() external returns (address);

    function getBVTokenAddress() external returns (address);

    function getVoteFactoryAddress() external returns (address);

    function setAttendanceAddress(address attendanceAddress) external;

    function setBVTokenAddress(address bvTokenAddress) external;

    function setVoteFactoryAddress(address voteFactoryAddress) external;
}
