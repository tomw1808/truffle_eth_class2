// Allows us to use ES6 in our migrations and tests.
require('babel-register');

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*' // Match any network id
    },
    live: {
      host: 'localhost', // Random IP for example purposes (do not use)
      port: 8545,
      network_id: 1,        // Ethereum public network
      from: '0x000fe3B327e85859eb26e9C6237fa6a34880CD68',
      gas: 1000000
    }
  }
};
