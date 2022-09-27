import { deployAllContracts } from "./deploy";
import { Vote, VoteFactory } from "../typechain";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";
import { expect } from "chai";
import { BigNumber } from "ethers";

let hrManager: SignerWithAddress;
let user1: SignerWithAddress;
let user2: SignerWithAddress;

let voteFactory: VoteFactory;
let vote1: Vote;

describe("투표 생성 테스트", () => {
    // Initial deployment function
    async function deploy() {
        const deployed = await deployAllContracts();
        hrManager = deployed.hrManager;
        user1 = deployed.user1;
        user2 = deployed.user2;

        voteFactory = deployed.voteFactory;
    }

    beforeEach(async () => {
        await deploy();

        const totalAudience = ethers.utils.parseEther("10");
        const rewardPresenter = ethers.utils.parseEther("100");
        const rewardAudience = ethers.utils.parseEther("5");
        await voteFactory.connect(hrManager).createVote(totalAudience, rewardPresenter, rewardAudience);

        const index = ethers.utils.parseEther("0");
        const voteAddress = await voteFactory.getVote(index);
        vote1 = (await ethers.getContractAt("Vote", voteAddress)) as Vote;
        console.log(`  🗂 index ${Number(index)} vote 컨트랙트 주소: ${vote1.address}`);
    });

    it("Factory 컨트랙트 변수가 정상적으로 세팅되는가? ", async () => {
        expect(await voteFactory.isVote(vote1.address)).to.eq(true);
        expect(await voteFactory.countVote()).to.eq(BigNumber.from("1"));
    });
});
