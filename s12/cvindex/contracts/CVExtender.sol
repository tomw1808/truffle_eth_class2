pragma solidity ^0.4.15;
contract CVExtender {
    function getDescription() public view returns (string);
    function getTitle() public view returns (string);
    function getAuthor() public view returns (string, string);
    function getAddress() public view returns (string);

    function elementsAreSet() public view returns (bool) {
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
