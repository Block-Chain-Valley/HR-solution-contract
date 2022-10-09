pragma solidity ^0.8.15;

interface IAttendance {
    enum AttendanceState {
        Absent,
        Late,
        Attend
    }

    function getAttendance(address, uint256) public view returns (attendanceState);

    function setAttendance(
        address,
        string,
        uint256
    ) external;
}
