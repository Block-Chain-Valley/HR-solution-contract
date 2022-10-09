pragma solidity ^0.8.15;

import "./interface/IVote.sol";

contract Vote is IVote {
    mapping(uint256 => VoteState) public voteStateMap;
    uint256 public countVote;

     function initialize() external {
        countVote = 0;
    }

    function initialize(
        uint256 totalAudience,
        uint256 rewardPresenter,
        uint256 rewardAudience,
        address[] memberList,
        address presenter
    ) external {
        VoteState voteState = (,,,,,,,);

        voteState._state = Ongoing;
        voteState._totalAudience = totalAudience;
        voteState._rewardPresenter = rewardPresenter;
        voteState._rewardAudience = rewardAudience;
        voteState._memberList =  memberList;
        voteState._presenter = presenter;
        voteState._startTime = block.timestamp;
        voteState._endTime = block.timestamp + 300;

        voteStateMap[countVote] = voteState; //uint와 VoteState 구조체 mapping인 voteStateMap에 VoteState 저장.

        countVote++;
    }

    function voteAudience(address walletAddress, uint256 totalAudience) external returns (bool result) {
    
        BVToken.giveReward(voteState._rewardAudience)
        /*
        input으로 주소 받고 require로 memberList에 지갑주소가 있는지
        현재 시간이 endTime보다 작은지
        require(block.timestamp<voteState._endTime)
        endTime이후에 memberList랑 지갑주소 비교해서 없으면 Success되지 않았다는 것을 return,
        memberList에 지갑주소 있으면 event로 Success return.

        */
        
            
        }
    
    }

    function voteResult() external view returns (VoteState memory voteState) {}
}
