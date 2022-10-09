pragma solidity ^0.8.15;

interface IAttendance {
    enum AttendanceState {
        Absent,
        Late,
        Attend
    }

    function getAttendance(address member, uint256 date) public view returns (attendanceState);

    function setAttendance(
        address member,
        string state,
        uint256 date
    ) external;
}
