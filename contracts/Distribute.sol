// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

error CannotDistribute();

contract Distribute {
    address[6] public contributors;
    uint256 public distributionTime;
    constructor(address[6] memory _contributors) payable {
        distributionTime = block.timestamp + 2 weeks;
        contributors = _contributors;
    }
    function distribute() external {
        if (block.timestamp <= distributionTime) revert CannotDistribute();
        uint256 amount;
        assembly {
            amount := div(selfbalance(), 6)
        }
        payable(contributors[0]).transfer(amount);
        payable(contributors[1]).transfer(amount);
        payable(contributors[2]).transfer(amount);
        payable(contributors[3]).transfer(amount);
        payable(contributors[4]).transfer(amount);
        payable(contributors[5]).transfer(amount);
    }
}