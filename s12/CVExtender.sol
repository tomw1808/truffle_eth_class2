pragma solidity ^0.4.8;
contract CVExtender {
    function getDescription() constant returns (string);
    function getTitle() constant returns (string);
    function getAuthor() constant returns (string, string);
    function getAddress() constant returns (string);
    
    function elementsAreSet() constant returns (bool) {
        //Normally I'd do whitelisting, but for sake of simplicity, lets do blacklisting
         
        bytes memory tempEmptyStringTest = bytes(getDescription());
        if(tempEmptyStringTest.length == 0) {
            return false;
        }
        tempEmptyStringTest = bytes(getTitle());
        if(tempEmptyStringTest.length == 0) {
            return false;
        }
        var (testString1, testString2) = getAuthor();
        
        tempEmptyStringTest = bytes(testString1);
        if(tempEmptyStringTest.length == 0) {
            return false;
        }
        tempEmptyStringTest = bytes(testString2);
        if(tempEmptyStringTest.length == 0) {
            return false;
        }
        tempEmptyStringTest = bytes(getAddress());
        if(tempEmptyStringTest.length == 0) {
            return false;
        }
        return true;
    }
}