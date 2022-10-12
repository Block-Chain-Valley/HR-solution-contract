pragma solidity ^0.8.15;

import "./IAttendance.sol";

interface IView {
    function getVoteAddress(uint256 date) external returns (address voteContractAddress);

    function getAttendanceAddress() external returns (address);

    function getBVTokenAddress() external returns (address);

    function getVoteFactoryAddress() external returns (address);

    function setAttendanceAddress(address attendanceAddress) external;

    function setBVTokenAddress(address bvTokenAddress) external;

    function setVoteFactoryAddress(address voteFactoryAddress) external;
}
