pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MataToken is ERC20, Ownable{

    uint256 public initTime;

    uint256 public lastMintTime;

    uint256 public dayAmount;
    
    constructor() ERC20("META", "Metacoin") {
        lastMintTime = block.timestamp;
        initTime = block.timestamp;
        dayAmount =  72000 * 10 ** 18;
    }

    function withdraw() public onlyOwner {
        require( (block.timestamp - lastMintTime) >  86400, "withdraw error");
        
        updateDayAmount();

        uint256 day = (block.timestamp - lastMintTime) / 86400;

        _mint(msg.sender, day * dayAmount );
    }

    function updateDayAmount() private {
        if( (block.timestamp  - initTime) / 86400 >  146) {
            dayAmount = dayAmount / 2;
            initTime = block.timestamp;
        }
    }
}