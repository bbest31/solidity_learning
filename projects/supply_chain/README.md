
Truffle Commands:

Initialize Empty Project: `truffle init`

Unbox truffle box for React: `truffle unbox react` http://trufflesuite.com/boxes/react/

Compile:              `truffle compile`

Migrate:              `truffle migrate`

Test contracts:       `truffle test`

Test dapp:            `cd client && npm test`

Run dev server:       `cd client && npm run start`

Build for production: `cd client && npm run build`

## Solidity Compiler Version

You can specify the compiler version for your contracts by editing the `truggle-config.js` file

ex.

```javascript
const path = require("path");

module.exports = {
    // See <http://truffleframework.com/docs/advanced/configuration>
    // to customize your Truffle configuration!
    contracts_build_directory: path.join(__dirname, "client/src/contracts"),
    networks: {
        develop: {
        port: 8545
        }
    },
    compilers: {
        solc: {
        version: "^0.6.0"
        }
    }
};
```

## Testing

To run a specific contract test file

`truffle test ./test/FileName.sol`

[Windows naming issue](http://trufflesuite.com/docs/truffle/reference/configuration#resolving-naming-conflicts-on-windows)

Run javascript test

`truffle test ./test/filename.js`

https://ethereum-blockchain-developer.com/050-supply-chain-project/09-create-unit-test/

http://trufflesuite.com/docs/truffle/testing/testing-your-contracts.html


## Compile Contracts

Run `truffle compile` in the root.

Contracts are compiled and written to ./build/contracts. This also builds the proper .json files to use the ABI's in the application.

## Using the Ganache local blockchain


### Option 1: Use Truffle Develop

In order to use a local blockchain simply use the following commands:

`truffle develop` - starts a ganache chain with accounts and the Truffle development instance.

Use `compile` and then `migrate` to deploy your compiled contracts to the blockchain.

### Option 2: Use Ganache Desktop App

In order to have the truffle application point to the Ganache app running on your computer you have to edit the truffle-config.js file and add the Ganache chain info.
This will allow a connection using Ganache's default connection parameters:

```javascript
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    }
  }
};
```

In the terminal use `truffle migrate` to get your contracts onto the Ganache chain.