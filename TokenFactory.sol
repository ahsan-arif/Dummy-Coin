//SPDX License -- MIT
pragma solidity ^0.8.5;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

//token address :  0xD4b86bb5BD81ef50Cd1ADA459a0833Aee09aF36b --deployed on ropsten test net

contract TokenFactory is ERC20{
    
    using SafeMath for uint256;
    
    address public owner;
    uint256 private _totalSupply;
    
     mapping(address => uint256) _balances;
    mapping(address => mapping(address=> uint256)) private _allowances;
    
    
    constructor () ERC20("Dummy Coin", "DC"){
        owner = msg.sender;
        _totalSupply = 100000000 * 10 **decimals();
        _balances[owner] = _totalSupply;
    }
    function decimals () public pure override returns(uint8){
        return 2;
    }
    
    function totalSupply () public view override returns(uint256){
        return _totalSupply;
    }
    
    function balanceOf(address account) public view override returns(uint256){
        return _balances[account];
    }
    
    function allowance(address owner, address spender) public view override returns(uint256){
        return _allowances[owner][spender];
    }
    
    function transfer (address recipient, uint256 amount) public override returns(bool){
        require(_balances[msg.sender]>=amount , "Insufficient balance in sender's account");
        _balances[msg.sender]=_balances[msg.sender].sub(amount);
        _balances[recipient]=_balances[recipient].add(amount);
        
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }
    
    function approve (address recipient,uint256 amount) public override returns(bool){
       // _approve(msg.sender,recipient,amount);
       require(_balances[msg.sender]>= amount, "Insufficient balance in sender's account");
       _allowances[msg.sender][recipient] = amount;
       
       emit Approval(msg.sender,recipient,amount);
        return true;
    }
    
    function transferFrom(address from, address to, uint256 amount) public override returns(bool){
       /* uint256 currentAllowance = _allowances[sender][recipient];
        require(_balances[sender] >= currentAllowance, "Insufficient balance in sender's account");
         currentAllowance = currentAllowance.sub(amount);
         _balances[sender] = _balances[sender].sub(amount);
         _balances[recipient] = _balances[recipient].add(amount);
         
         emit Transfer(sender,recipient,amount);
         
         _allowances[sender][recipient] = currentAllowance;
         
         emit Approval(sender,recipient,amount);*/
         
        _balances[from] = _balances[from].sub(amount);
        _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(amount);
        _balances[to] = _balances[to].add(amount);
        emit Transfer(from, to, amount);
         
         return true;
    }
    
}
