pragma solidity ^0.5.0;

contract MyContract {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function getCreator() public view returns(address) {
        return owner;
    }

    function kill() public {
        if(msg.sender == owner) {
            selfdestruct(msg.sender);
        }
    }
}
