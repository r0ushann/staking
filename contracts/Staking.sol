//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error Staking__TransferFailed();


contract Staking{

    IERC20 public s_stakingToken;

    mapping(address => uint256) public s_balances;

    uint256 public s_totalSupply;

    modifier updateReward(address account) {
       _; 
    }

    constructor(address stakingToken){
        s_stakingToken = IERC20(stakingToken);
    }

    function stake(uint256 amount)external{
        //keep track of how much this user has staked
        //keep track of how much token we have in total
            //transfer the tokens to this contract
        s_balances[msg.sender] = s_balances[msg.sender] + amount;
        s_totalSupply = s_totalSupply + amount;
        //emit event
       bool success =  s_stakingToken.transferFrom(msg.sender, address(this), amount);
      // require(success , "Failed");
      if(!success){
        revert Staking__TransferFailed();
       }

    }

    function withdraw(uint256 amount)external{
        s_balances[msg.sender] = s_balances[msg.sender] - amount;
        s_totalSupply = s_totalSupply - amount;
        bool success = s_stakingToken.transfer(msg.sender , amount);

        if(!success){
            revert Staking__TransferFailed();
        }


    }

    function claimReward() external{
        // How much reward do they get?


    }
}