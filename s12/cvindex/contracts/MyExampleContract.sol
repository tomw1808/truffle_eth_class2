pragma solidity ^0.4.15;

import "./CVExtender.sol";

contract MyExampleContract is CVExtender {

    /**
     * Your functions go here
     *
     * */

    function MyFunction1() {}
    function MyFunction2() {}


    /**
     * Below is for our CV!
     * */
    function getAddress() public constant returns(string) {
        return "http://www.example.org";
    }

    function getDescription() public constant returns(string) {
        return "This is an example";
    }
    function getTitle() public constant returns(string) {
        return "SimpleExample";
    }
    function getAuthor() public constant returns(string, string) {
        return ("Thomas", "thomas@example.org");
    }
}