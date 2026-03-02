// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulboundBadge is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    event BadgeMinted(address indexed to, uint256 indexed tokenId, string uri);

    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) 
        Ownable(msg.sender) 
    {}

    /**
     * @dev Mints a new soulbound badge. Only the owner (issuer) can mint.
     */
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        emit BadgeMinted(to, tokenId, uri);
    }

    /**
     * @dev Standard ERC-721 transfer override. 
     * Reverts on any transfer attempt to ensure the token remains soulbound.
     */
    function _update(address to, uint256 tokenId, address auth)
        internal
        override
        returns (address)
    {
        address from = _ownerOf(tokenId);
        if (from != address(0) && to != address(0)) {
            revert("SoulboundToken: Transfer is prohibited");
        }
        return super._update(to, tokenId, auth);
    }

    /**
     * @dev Allows the issuer to revoke a badge if necessary.
     */
    function burn(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }
}
