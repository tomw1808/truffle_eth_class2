pragma solidity ^0.4.8;

contract MyContract {
    address owner;
    
    function MyContract() {
        owner = msg.sender;
    }
    
    function getCreator() constant returns(address) {
        return owner;
    }
    
    function kill() {
        if(msg.sender == owner) {
            selfdestruct(msg.sender);
        }
    }
}