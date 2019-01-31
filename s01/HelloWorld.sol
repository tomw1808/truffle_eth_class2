pragma solidity ^0.5.0;

contract HelloWorld {
    uint256 counter;

    function increase() public {
        counter++;
    }

    function decrease() public {
        counter--;
    }

    function getCounter() public view returns (uint256){
        return counter;
    }
}
