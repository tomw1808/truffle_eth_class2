pragma solidity ^0.4.0;
contract MyContract {
    address creator;
    uint256 myNumber;

    event NumberIsIncreased(address indexed whoIncreased, uint256 indexed oldNumber, uint256 indexed newNumber);

    function MyContract() {
        creator = msg.sender;
        myNumber = 3;
    }

    function getCreator() constant returns(address) {
        return creator;
    }

    function getMyNumber() constant returns(uint256) {
        return myNumber;
    }

    function setMyNumber(uint256 myNewNumber) {
        NumberIsIncreased(msg.sender, myNumber, myNewNumber);
        myNumber = myNewNumber;
    }

    function kill() {
        if(msg.sender == creator) {
            suicide(creator);
        }
    }
}