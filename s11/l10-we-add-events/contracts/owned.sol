pragma solidity ^0.4.15;

contract owned {
    address owner;

    modifier onlyowner() {
        /**
         * Update Exception Handling from Solidity 0.4.13!
         * See: https://vomtom.at/exception-handling-in-solidity/
         * If you have any questions, head over to the course Q&A!
         **/
        require(msg.sender == owner);
        _;
    }

    function owned() public {
        owner = msg.sender;
    }
}
