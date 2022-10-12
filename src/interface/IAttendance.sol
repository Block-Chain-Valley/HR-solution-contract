pragma solidity ^0.8.15;

interface IAttendance {
    function getAttendance(address member, uint256 date) external view returns (string memory attendance);

    function setAttendance(
        address member,
        string memory state,
        uint256 date
    ) external;
}
