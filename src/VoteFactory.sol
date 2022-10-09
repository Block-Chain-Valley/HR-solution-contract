//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "./interface/IVoteFactory.sol";
import "./Vote.sol";

contract VoteFactory is IVoteFactory {
    // 투표 index -> 투표 컨트랙트 주소
    mapping(uint256 => address) public getVote;
    // 투표 컨트랙트 주소 => 컨트랙 존재 유무 //
    mapping(address => bool) public isVote;

    // event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    constructor() {}

    function createVote(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memory memberList,
        address presenter,
        uint256 date
    ) external {
        address voteAddr;
        bytes memory bytecode = type(Vote).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(date));
        assembly {
            voteAddr := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IVote(voteAddr).initialize(totalAudience, rewardPresenter, rewardAudience, memberList, presenter);

        getVote[date] = voteAddr;
        isVote[voteAddr] = true;

        // emit VoteCreated();
    }

    function getVoteAddress(uint256 date) external returns (address) {
        return getVote[date];
    }
}
