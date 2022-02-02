// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract Voting {

    // Modeling a Candidate
    struct Candidate {
        uint id;
        string name;
        string party;
        uint voteCount;
    }   

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates and fetch candidate
    mapping(uint => Candidate) public candidates;

    // store candidates count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed_candidateId
    );

    constructor () public {
        addCandidate("Amit shah","Bharatiya Janata Party");
        addCandidate("Sankar Malakar","Indian National Congress");
        addCandidate("Saman Pathak","Communist Party Of India (Marxist)");
        addCandidate("Amar Singh","All India Trinamool Congress");
        addCandidate("Sudip Mandal","Bahujan Samaj Party");
        addCandidate("NOTA","None of the above");
    }

    function addCandidate(string memory _name, string memory _party) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount,_name,_party,0);
    }

    function vote (uint _candidateId) public {
        // check that they haven't voted before
        require(!voters[msg.sender]);

        // check he/she is a valid candidate
        require(_candidateId > 0 && _candidateId<= candidatesCount);

        // record that voter has voted 
        voters[msg.sender] = true;

        // update candidate vote count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}