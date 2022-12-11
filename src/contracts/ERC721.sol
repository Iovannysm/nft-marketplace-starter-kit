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

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
  function balanceOf(address _owner) public view returns(uint256){
    require(_owner != address(0), 'owner query for non-existent token');
    return _OwnedTokenCount[_owner];
  }
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
  function ownerOf(uint256 _tokenId) external view returns(address){
    address owner = _tokenOwner[_tokenId];
    require(owner != address(0), 'owner query for non-existent token');
    return owner;
  }

  function _exist(uint256 tokenId) internal view returns(bool){
    // setting the address of nft owner to check the mapping
    // of the address from tokenOwner at the tokenId 
    address owner = _tokenOwner[tokenId];
    // return truthiness that the address is not zero 
    return owner != address(0);
  }

  function _mint(address to, uint256 tokenId) internal virtual {
    // requires that the addres isn't zero
    require(to != address(0), 'ERC721: minting to the zero address');
    // requires thay the token doesn not already exist
    require(!_exist(tokenId), 'ERC721: token already minted');
    // we are addding a new address with a token Id for minting 
    _tokenOwner[tokenId] = to;
    // keeping track of each address that is minting and adding one  
    _OwnedTokenCount[to] += 1;

    emit Transfer(address(0), to, tokenId);
  }

}