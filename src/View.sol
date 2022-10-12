pragma solidity ^0.8.15;

import "./interface/IView.sol";
import "./interface/IAttendance.sol";
import "./interface/IBVToken.sol";
import "./interface/IVoteFactory.sol";
import "./interface/IVote.sol";
import "./interface/IAttendance.sol";
import "./common/Ownable.sol";

contract View is Ownable, IView {
    address private _attendanceAddress;
    address private _bvTokenAddress;
    address private _voteFactoryAddress;

    function getVoteAddress(uint256 date) public returns (address voteContractAddress) {
        return IVoteFactory(_voteFactoryAddress).getVoteAddress(date);
    }

    function getAttendanceAddress() public returns (address) {
        return _attendanceAddress;
    }

    function getBVTokenAddress() public returns (address) {
        return _bvTokenAddress;
    }

    function getVoteFactoryAddress() public returns (address) {
        return _voteFactoryAddress;
    }

    function setAttendanceAddress(address attendanceAddress) public onlyOwner {
        _attendanceAddress = attendanceAddress;
    }

    function setBVTokenAddress(address bvTokenAddress) public onlyOwner {
        _bvTokenAddress = bvTokenAddress;
    }

    function setVoteFactoryAddress(address voteFactoryAddress) public onlyOwner {
        _voteFactoryAddress = voteFactoryAddress;
    }

    // Attendance.sol
    function getAttendanceStatus(address user, uint256 date) external returns (string memory attendance) {
        attendance = IAttendance(_attendanceAddress).getAttendance(user, date);
    }

    // IVoteFactory.sol
    function getAllVoteStatus() external returns (VoteStatus[] memory allVoteStatus) {
        uint256 voteNum = IVoteFactory(_voteFactoryAddress).allVotesLength();
        allVoteStatus = new VoteStatus[](voteNum);

        for (uint256 i = 0; i < voteNum; i++) {
            address _voteAddr = IVoteFactory(_voteFactoryAddress).allVotes(i);
            IVote.VoteState memory vote = IVote(_voteAddr).getVote();
            allVoteStatus[i].voteAddr = _voteAddr;
            allVoteStatus[i].state = vote._state;
            allVoteStatus[i].totalAudience = vote._totalAudience;
            allVoteStatus[i].approvedAudience = vote._approvedAudience;
            allVoteStatus[i].startTime = vote._startTime;
            allVoteStatus[i].endTime = vote._endTime;
            allVoteStatus[i].rewardPresenter = vote._rewardPresenter;
            allVoteStatus[i].rewardAudience = vote._rewardAudience;
            allVoteStatus[i].memberList = vote._memberList;
            allVoteStatus[i].presenter = vote._presenter;
        }
    }

    function getVoteStatusWithAddress(address _voteAddr) external returns (VoteStatus memory voteStatus) {
        IVote.VoteState memory vote = IVote(_voteAddr).getVote();
        voteStatus.voteAddr = _voteAddr;
        voteStatus.state = vote._state;
        voteStatus.totalAudience = vote._totalAudience;
        voteStatus.approvedAudience = vote._approvedAudience;
        voteStatus.startTime = vote._startTime;
        voteStatus.endTime = vote._endTime;
        voteStatus.rewardPresenter = vote._rewardPresenter;
        voteStatus.rewardAudience = vote._rewardAudience;
        voteStatus.memberList = vote._memberList;
        voteStatus.presenter = vote._presenter;
    }
}
