// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

error CannotDistribute();

contract DistributeAssembly {
    address[6] public contributors;
    uint256 public distributionTime;
    constructor(address[6] memory _contributors) payable {
        distributionTime = block.timestamp + 2 weeks;
        contributors = _contributors;
    }
    function distribute() external {
        if (block.timestamp <= distributionTime) revert CannotDistribute();
        assembly {
            let amount := div(selfbalance(), 6)

            // Get the storage slots for contributors array
            let contributorsSlot := sload(contributors.slot)

            // Contributor 0
            let contributor0 := sload(add(contributorsSlot, 0x00))
            pop(call(gas(), contributor0, amount, 0, 0, 0, 0))

            // Contributor 1
            let contributor1 := sload(add(contributorsSlot, 0x20))
            pop(call(gas(), contributor1, amount, 0, 0, 0, 0))

            // Contributor 2
            let contributor2 := sload(add(contributorsSlot, 0x40))
            pop(call(gas(), contributor2, amount, 0, 0, 0, 0))

            // Contributor 3
            let contributor3 := sload(add(contributorsSlot, 0x60))
            pop(call(gas(), contributor3, amount, 0, 0, 0, 0))

            // Contributor 4
            let contributor4 := sload(add(contributorsSlot, 0x80))
            pop(call(gas(), contributor4, amount, 0, 0, 0, 0))

            // Contributor 5
            let contributor5 := sload(add(contributorsSlot, 0xA0))
            pop(call(gas(), contributor5, amount, 0, 0, 0, 0))
        }
    }
}