module.exports = {
  networks: {
    dashboard: {
      port: 24012,
    },
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    loc_jascoin: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.13",  // Specify the version of Solidity you're using
      settings: {
        optimizer: {
          enabled: true,
          runs: 200  // This is the number of contract runs expected to be made during its lifetime. Adjusting this can have huge effects on gas costs.
        }
      }
    }
  }
};
