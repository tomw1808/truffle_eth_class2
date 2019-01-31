pragma solidity ^0.5.0;

import "CVExtender.sol";

contract Example is CVExtender {

    /**
     * Your functions go here
     *
     * */

    function MyFunction1() {}
    function MyFunction2() {}


    /**
     * Below is for our CV!
     * */
    function getAddress() public view returns(string memory) {
        return "http://www.vomtom.at";
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
