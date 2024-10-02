// contracts/onChainNFT.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import {Base64} from "./Base64.sol";

contract HappyOnChain is ERC721URIStorage{
    event Minted(uint256 tokenId);

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("OnChainNFT", "ONC") {}

    /* Converts an SVG to Base64 string */
    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    /* Generates a tokenURI using Base64 string as the image */
    function formatTokenURI(string memory imageURI)
        public
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "LCM ON-CHAINED", "description": "A simple SVG based on-chain NFT", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /* Mints the token */
    function mint(string memory svg) public onlyOwner {
        string memory imageURI = svgToImageURI(svg);
        string memory tokenURI = formatTokenURI(imageURI);

        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit Minted(newItemId);
    }

    function svgToImageURI(string memory svg)
    public
    pure
    returns (string memory)
{
    string memory baseURL = "data:image/svg+xml;base64,";
    string memory svgBase64Encoded = Base64.encode(bytes(svg));
    /* 
      abi.encodePacked is a function provided by Solidity which
      is used to concatenate two strings, similar to a `concat()`
      function in JavaScript.
    */
    return string(abi.encodePacked(baseURL, svgBase64Encoded));
}

function simplifiedFormatTokenURI(string memory imageURI)
    public
    pure
    returns (string memory)
{
    string memory baseURL = "data:application/json;base64,";
    string memory json = string(
        abi.encodePacked(
            '{"name": "I am  Happy ", "description": "A simple SVG based on-chain happy boy", "image":"',
            imageURI,
            '"}'
        )
    );
    string memory jsonBase64Encoded = Base64.encode(bytes(json));
    return string(abi.encodePacked(baseURL, jsonBase64Encoded));
}



}
