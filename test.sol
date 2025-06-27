// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Event {
    
    // Event metadata
    address public creatorAddress;
    string public eventName;
    string public location;
    uint64 public startTime;
    uint64 public endTime;
    uint64 public registeredCount;

    // Mapping from participant address to their transaction hash (used as registration ID)
    mapping(address => bytes32) public registeredMap;

    // Constructor-style function to initialize event (used instead of TEAL's `createApplication`)
    function createApplication(
        string memory _eventName,
        string memory _location,
        uint64 _startTime,
        uint64 _endTime
    ) public {
        require(creatorAddress == address(0), "Event already created");
        
        creatorAddress = msg.sender;
        eventName = _eventName;
        location = _location;
        startTime = _startTime;
        endTime = _endTime;
        registeredCount = 0;
    }

    // Function to register a user for the event
    function registerEvent() public {
        require(registeredMap[msg.sender] == 0x0, "Already registered");

        registeredCount += 1;
        registeredMap[msg.sender] = keccak256(abi.encodePacked(block.number, msg.sender, registeredCount));
    }
}
