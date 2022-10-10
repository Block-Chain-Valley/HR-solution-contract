pragma solidity ^0.8.15;

import "./interface/IAttendance.sol";

contract Attendance is IAttendance {
    mapping(address => mapping(uint256 => AttendanceState)) public attendanceStatus;

    function getAttendance(address member, uint256 date) public view returns (AttendanceState) {
        return attendanceStatus[member][date];
    }

    function setAttendance(
        address member,
        string state,
        uint256 date
    ) public returns () {
        require(attendanceStatus[member][date] == 0, "State is already written.");
        attendanceStatus[member][date] = AttendanceState(state);
    }
}
