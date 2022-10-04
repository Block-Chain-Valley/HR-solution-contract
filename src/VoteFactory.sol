//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "./interface/IVoteFactory.sol";
import "./Vote.sol";

contract VoteFactory is IVoteFactory {
    // 투표 index -> 투표 컨트랙트 주소
    mapping(uint256 => address) public getVote;
    // 투표 컨트랙트 주소 => 컨트랙 존재 유무 //
    mapping(address => bool) public isVote;
    uint256 public countVote;

    // event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    constructor() {}

    function initialize() external {
        countVote = 0;
    }

    function createVote(
        uint256 _totalAudience,
        uint256 _rewardPresenter,
        uint256 _rewardAudience,
        address[] _audience
    ) external returns (address voteAddr) {
        uint256 localCountVote = countVote;

        bytes memory bytecode = type(Vote).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(localCountVote));
        assembly {
            voteAddr := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        IVote(voteAddr).initialize(_totalAudience, _rewardPresenter, _rewardAudience, _audience);

        getVote[localCountVote] = voteAddr;
        isVote[voteAddr] = true;

        countVote = localCountVote + 1;
        // emit VoteCreated();
    }
}
