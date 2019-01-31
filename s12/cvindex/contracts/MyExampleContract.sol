pragma solidity ^0.5.0;

import "./CVExtender.sol";

contract MyExampleContract is CVExtender {

    /**
     * Your functions go here
     *
     * */

    function MyFunction1() public {}
    function MyFunction2() public {}


    /**
     * Below is for our CV!
     * */
    function getAddress() public view returns(string memory) {
        return "http://www.example.org";
    }

    function getDescription() public view returns(string memory) {
        return "This is an example";
    }
    function getTitle() public view returns(string memory) {
        return "SimpleExample";
    }
    function getAuthor() public view returns(string memory, string memory) {
        return ("Thomas", "thomas@example.org");
    }
}