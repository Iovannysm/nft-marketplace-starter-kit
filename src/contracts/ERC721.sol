// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

  event Transfer(
    address indexed from,
    address indexed to,
    uint256 indexed tokenId
    );

  //Mapping from the token Id to the owner
  mapping(uint => address) private _tokenOwner;

  //Mapping from onwer to the number of owned tokens
  mapping(address => uint) private _OwnedTokenCount;

  function _exist(uint256 tokenId) internal view return(bool){
    // setting the address of nft owner to check the mapping
    // of the address from tokenOwner at the tokenId 
    address owner = _tokenOwner[tokenId];
    // return truthiness that the address is not zero 
    return owner =! address(0);
  }

  function _mint(address to, uint256 tokenID) internal {
    // requires that the addres isn't zero
    require(to != address(0), 'ERC721: minting to the zero address');
    // requires thay the token doesn not already exist
    require(!_exist(tokenId), 'ERC721: token already minted');
    // we are addding a new address with a token Id for minting 
    _tokenOwner[tokenID] = to;
    // keeping track of each address that is minting and adding one  
    _OwnedTokenCount[to] += 1;
  }

  emit tranasfer(address(0), to, tokenId);
}