pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public  minter;
    mapping(address => uint ) public  balances;

    constructor() {
        minter = msg.sender;
    }
    event Sent(address from, address to, uint amount);
    modifier onlyOwner(){
        require(msg.sender == minter);
        _;
    }

    function mint(address payable receiver, uint  amount) public payable  onlyOwner {
        balances[receiver] += amount; 
    }
    error inssuficientBalance(uint requested, uint available);
    function send(address receiver, uint amount) public  {
        if(amount > balances[msg.sender])
        revert inssuficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);

    }


}