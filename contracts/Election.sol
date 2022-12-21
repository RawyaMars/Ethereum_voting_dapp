pragma solidity ^0.5.0;

contract Election {
    address [5] public Admin;
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have voted
    mapping(address => bool) public voters;
    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;
    modifier onlyAdmin(){
        require(isAdmin());
        _;
      }
    
    constructor(address [5] memory _admins) public {
	    Admin=_admins;
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    event votedEvent (
	uint indexed _candidateId );
    function addCandidate (string memory _name) public onlyAdmin {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    function vote (uint _candidateId) public {
	// require that they haven't voted before
    require(!voters[msg.sender]);
	// require a valid candidate
	require(_candidateId > 0 && _candidateId <= candidatesCount);
	// record that voter has voted
	voters[msg.sender] = true;
	// update candidate vote Count
	candidates[_candidateId].voteCount ++;
	emit votedEvent(_candidateId);
	}
    function isAdmin () public view returns (bool){
        for (uint i; i< Admin.length;i++){
            if (Admin[i]==msg.sender) return true;}
        }
}
