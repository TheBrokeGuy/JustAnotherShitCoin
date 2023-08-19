// Just Another $hit Coin 
//
// No purpose. No value. It's just another shit coin.
//
// Website: https://pleasegiveme.money
//
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JustAnotherShitCoin is ERC20, Ownable, Pausable {
  
  // 1,000,000 tokens with 18 decimal places
  uint256 INITIAL_SUPPLY = 1000000 * 10**decimals(); 
  // 1 billion tokens with 18 decimal places
  uint256 MAX_SUPPLY = 1_000_000_000 * 10**decimals();
  // Setting minimum transaction amount to discourage Augustus Gloop from eating all the tokens
  uint MIN_ETHER = 1e15;  // 0.001 ETH

  address public _owner;
  
  constructor() ERC20("Just Another $hit Coin", "POOP") {
     
     // Account that deployed the contract
     _owner = msg.sender; 
       
     // 0.1 % of MAX_SUPPLY reserved for The Broke Guy
     _mint(msg.sender, INITIAL_SUPPLY);

     }
     
     receive() external payable whenNotPaused {
         // Gimme my ETH or you gets no tokens!
         require(msg.value >= MIN_ETHER, "Oops! The amount sent is below the minimum requirement.");
         
         // Getting (psuedo) random number for token amount
         uint256 randomAmount = getRandomAmount(msg.sender);
         
         // You can never have enough decimals.
         uint256 mintAmount = randomAmount * 10**decimals(); // Respect 5 token decimals
         
         // Can't send more than tokens than the amount minted
         require(totalSupply() + mintAmount <= MAX_SUPPLY * 10**decimals(), "Sorry. The supply of tokens has been exhausted");
         
         //Over transaction minimum? Check. Under MAX_SUPPLY? Check. Sending tokens.
         _mint(msg.sender, mintAmount);
     }

    // I know. It's not REALLY random but if you have the time, energy,
    // and resources to guess the number then you REALLY need to get a life.
    function getRandomAmount(address sender) private view returns (uint256) {
        uint256 random = uint256(keccak256(abi.encodePacked(
            block.timestamp,
            block.difficulty,
            sender,
            blockhash(block.number - 1)
        ))) % 901;
        // Number from 100 to 1000
        return random + 100; 
     } 
     
    // I'm rich bitch!
    function withdraw() public onlyOwner whenNotPaused {
        payable(owner()).transfer(address(this).balance);
    }

    // Why are you all in my business?
    function owner() override public view returns (address) {
        return _owner;
     }
   
    // To pause...
    function pause() external onlyOwner whenNotPaused {
        _pause();
    }
    
    // ...or not to pause... that is the function
    function unpause() external onlyOwner whenPaused {
        _unpause();
    }

}
