// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./abstract/ERC1175.sol";

contract ByteHelix is ERC1175 {

    // 60% public sale
    // 10% uniswap v2
    // 20% kol or vote?
    // 10% team

    using Strings for uint256;


    uint256 initTotal = 1_000_000_000;
    uint256 private maxUint256 = type(uint256).max;
    uint256 public MAX_QUANTITY =10;
    uint256 public PER_BALANCE = 0.1 ether;
    uint256 public PER_REWARD = 1_000_000 ether;
    mapping(address => uint256) public contributors;
    
    string baseURI;

    address public router = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    struct SocialLink {
        string x;
        string github;
        string website;
    }
    
    SocialLink public  socialLink;
    constructor() ERC1175("ByteHelix 1175", "BHX", 18, initTotal, "ipfs://QmcWpx8eKB6T3KUAEJZrwAFq5th2cYA85YhNDSX4UtNgjr/") {
        _balances[msg.sender] = initTotal * 10 ** 18 * 4/10;
        _balances[address(this)] = initTotal * 10 ** 18 * 6/10;

        whitelist[address(this)] = true;
        whitelist[msg.sender] = true;
        whitelist[router] = true;
        _allowances[msg.sender][router] = maxUint256;
        baseURI = "ipfs://QmcWpx8eKB6T3KUAEJZrwAFq5th2cYA85YhNDSX4UtNgjr/";
        socialLink.x ="https://twitter.com/ERC1175";
        socialLink.website ="https://www.bytehelix.org";
        socialLink.github ="https://github.com/bytehelix";
    }

    function setBaseURI(string memory uri_) public onlyOwner {
        baseURI = uri_;
    }

    function setSocialLink(string memory x,string memory github,string memory website) public onlyOwner{
        socialLink.x = x;
        socialLink.github = github;
        socialLink.website = website;
    }

    function uri(uint256 id) public view  override returns (string memory) {
        return bytes(baseURI).length > 0 ? string.concat(baseURI, id.toString(), ".json") : "";
    }

    function buy(uint256 quantity) public payable {
        // The Lucky One to Discover a New World
        require(quantity <= MAX_QUANTITY,"quantify overflow");
        require(contributors[msg.sender] + quantity <= MAX_QUANTITY,"max quantify overflow");
        uint256 cost = quantity * PER_BALANCE;
        require(msg.value >= cost,"balance too small");
        if (msg.value >cost) {
            uint256 refund = msg.value -cost;
            payable(msg.sender).transfer(refund);
        }
        contributors[msg.sender] += quantity;
        uint256 reward = PER_REWARD * quantity;
        this.transfer(msg.sender, reward);
    }

    function withdraw(address token_,uint256 amount) public onlyOwner  {
        if (token_ == address(0)) {
            require(address(this).balance >0, "Error: insufficient balance");
            uint256 fee =address(this).balance;
            payable(msg.sender).transfer(fee);
        }else{
            uint256 fee = IERC20(token_).balanceOf(address(this));
            require(amount <= fee, "Error: owerflow fee");
            IERC20(token_).transfer(msg.sender, amount);
        }
    }

}
