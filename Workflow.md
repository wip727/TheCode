%% Workflow


TheCode.deployed().then(function(i){coin = i})
ItemBank.deployed().then(function(i){app = i})
[u0, u1, sword] = web3.eth.accounts.slice(0, 3)
app.registerItem(sword, u1, 10000, 999, 3)
coin.transfer(app.address, 999)
app.borrowItem(coin.address, sword)



% Metropolis update
coin.approve(app.address, 999)
app.borrowItem(coin.address, sword)