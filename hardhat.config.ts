import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require ("dotenv").config({ path: './.env'})


const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_KEY = process.env.APIKEY;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
    networks: {
    sepolia: {
      url:`https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan:{
    apiKey: `${ETHERSCAN_KEY}`,
  },
};

export default config;
