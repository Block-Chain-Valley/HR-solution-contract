pragma solidity ^0.8.15;

import "./interface/IAttendance.sol";

contract Attendance is IAttendance {
    event AttendanceResult(uint256 indexed date, address indexed member, string indexed status);

    mapping(address => mapping(uint256 => string)) public attendanceStatus;

    function getAttendance(address member, uint256 date) external view returns (string memory attendance) {
        return attendanceStatus[member][date];
    }

    function setAttendance(
        address member,
        string memory state,
        uint256 date
    ) external {
        require(bytes(attendanceStatus[member][date]).length == 0, "State is already written.");
        attendanceStatus[member][date] = state;
        emit AttendanceResult(date, member, state);
    }
}
