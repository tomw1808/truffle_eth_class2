pragma solidity ^0.5.0;

contract owned {
    address payable owner;

    modifier onlyowner() {
        /**
         * Update Exception Handling from Solidity 0.4.13!
         * See: https://vomtom.at/exception-handling-in-solidity/
         * If you have any questions, head over to the course Q&A!
         **/
        require(msg.sender == owner, "Owner is not the msg.sender");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
}
