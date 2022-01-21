// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
    
// 14th Person to deposit 1 ether wins it all

contract EtherGame {
    using SafeMath for uint;

    address public winner;
    uint public targetAmount  = 14 ether;
    uint public balance=0;

    function deposit() public payable{
        require(msg.value==1 ether,"Please deposit 1 ether.");
        balance += msg.value;

        require(balance <= targetAmount,"Game is Over");
        if(balance == targetAmount){
            winner = msg.sender;
        }
    }

    function withdraw() public payable{
        require(msg.sender == winner,"Not Authorized");
        require(address(this).balance == balance,"Cannot Withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }

    function restart() public {
        winner = address(0);
    }
}