// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {
    
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public owner;
    bool public votingActive;

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
        votingActive = false;
    }

    // Add candidates before voting starts
    function addCandidate(string memory _name) external {
        require(msg.sender == owner, "Only owner can add candidates");
        require(!votingActive, "Cannot add candidates after voting starts");

        candidates.push(Candidate({
            name: _name,
            voteCount: 0
        }));
    }

    // Start the voting process
    function startVoting() external {
        require(msg.sender == owner, "Only owner can start");
        require(!votingActive, "Voting already active");
        votingActive = true;
    }

    // Stop voting
    function stopVoting() external {
        require(msg.sender == owner, "Only owner can stop");
        require(votingActive, "Voting not active");
        votingActive = false;
    }

    // Vote for a candidate by index
    function vote(uint256 candidateIndex) external {
        require(votingActive, "Voting is not active");
        require(!hasVoted[msg.sender], "You already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
    }

    // Get total number of candidates
    function getCandidateCount() external view returns (uint256) {
        return candidates.length;
    }

    // Get candidate details
    function getCandidate(uint256 index) external view returns (string memory, uint256) {
        Candidate memory c = candidates[index];
        return (c.name, c.voteCount);
    }
}

