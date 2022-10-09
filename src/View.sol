pragma solidity ^0.8.15;

import "./interface/IView.sol";
import "./interface/IAttendance.sol";
import "./interface/IBVToken.sol";
import "./interface/IVoteFactory.sol";
import "./common/Ownable.sol";

contract View is Ownable, IView {
    address private _attendanceAddress;
    address private _bvTokenAddress;
    address private _voteFactoryAddress;

    function getAttendance(address member, uint256 date) public returns (AttendanceState) {
        return IAttendance(attendanceAddress).getAttendance(member, date);
    }

    function getVoteAddress(uint256 date) public returns (address voteContractAddress) {
        return IVoteFactory(voteFactoryAddress).getVoteAddress(date);
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
}
