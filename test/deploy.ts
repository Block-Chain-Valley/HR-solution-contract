import { ethers, upgrades } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { VoteFactory, Vote, TestToken } from "../typechain";

export interface RT {
    hrManager: SignerWithAddress;
    user1: SignerWithAddress;
    user2: SignerWithAddress;
    voteFactory: VoteFactory;
    BVToken: TestToken;
}

export const deployAllContracts = async (): Promise<RT> => {
    const [hrManager, user1, user2] = await ethers.getSigners();

    const BvTokenContract = await ethers.getContractFactory("TestToken");
    const BVToken = (await BvTokenContract.deploy("Blockchain Valley Token", "BVT", 18)) as TestToken;
    await BVToken.deployed();

    const VoteFactoryContract = await ethers.getContractFactory("VoteFactory");
    const voteFactory = (await VoteFactoryContract.deploy()) as VoteFactory;
    await voteFactory.deployed();

    return {
        hrManager,
        user1,
        user2,
        BVToken,
        voteFactory,
    };
};
