pragma solidity ^0.4.0;
contract MyContract {
    address creator;
    uint256 myNumber;

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
        myNumber = myNewNumber;
    }

    function kill() {
        if(msg.sender == creator) {
            suicide(creator);
        }
    }
}