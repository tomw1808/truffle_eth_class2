pragma solidity ^0.4.8;

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
    function getAddress() constant returns(string) {
        return "http://www.example.org";
    }
    
    function getDescription() constant returns(string) {
        return "This is an example";
    }
    function getTitle() constant returns(string) {
        return "SimpleExample";
    }
    function getAuthor() constant returns(string, string) {
        return ("Thomas", "thomas@example.org");
    }
}