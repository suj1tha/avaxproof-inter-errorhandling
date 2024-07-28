// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CrowdfundedLottery {
    address public owner;
    uint256 public lotteryEndTime;
    uint256 public ticketPrice;
    uint256 public prizePool;
    bool public lotteryEnded;

    address[] public participants;

    event LotteryStarted(uint256 endTime);
    event TicketPurchased(address indexed participant, uint256 amount);
    event WinnerDeclared(address indexed winner, uint256 prize);

    constructor(uint256 durationMinutes, uint256 _ticketPrice) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        lotteryEndTime = block.timestamp + (durationMinutes * 1 minutes);
        emit LotteryStarted(lotteryEndTime);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyBeforeEnd() {
        require(block.timestamp < lotteryEndTime, "Lottery has ended");
        _;
    }

    modifier onlyAfterEnd() {
        require(block.timestamp >= lotteryEndTime, "Lottery is still ongoing");
        _;
    }

    function buyTicket() external payable onlyBeforeEnd {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        participants.push(msg.sender);
        prizePool += msg.value;
        emit TicketPurchased(msg.sender, msg.value);
    }

    function endLottery() external onlyOwner onlyAfterEnd {
        require(!lotteryEnded, "Lottery has already ended");
        if (participants.length == 0) {
            revert("No participants in the lottery");
        }

        uint256 winnerIndex = _random() % participants.length;
        address winner = participants[winnerIndex];

        prizePool = 0;
        lotteryEnded = true;
        (bool sent, ) = winner.call{value: address(this).balance}("");
        assert(sent);

        emit WinnerDeclared(winner, address(this).balance);
    }

    function _random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
    }

    receive() external payable {
        prizePool += msg.value;
    }
}
