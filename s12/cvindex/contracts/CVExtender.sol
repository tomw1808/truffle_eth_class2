pragma solidity ^0.5.0;
contract CVExtender {
    function getDescription() public view returns (string memory);
    function getTitle() public view returns (string memory);
    function getAuthor() public view returns (string memory, string memory);
    function getAddress() public view returns (string memory);

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
        (string memory testString1, string memory testString2) = getAuthor();

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