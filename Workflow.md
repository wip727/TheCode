%% Workflow

% Save contract to 'coin'
TheCode.deployed().then(function(i){coin = i})

% Save contract to 'app'
ItemBank.deployed().then(function(i){app = i})

% u0 - borrower, u1 - owner, sword - item
[u0, u1, sword] = web3.eth.accounts.slice(0, 3)

% Register sword with max time = 10000, deposit = 999, chargeRate = 3 
app.registerItem(sword, u1, 10000, 999, 3)

% Send deposit approval to app address
coin.approve(app.address, 999)

% Borrow the item, transfer the deposit to app
app.borrowItem(coin.address, sword)

% Return the item, transfer the charge to owner and refund the deposit
app.returnItem(coin.address, sword)

% Reset the approval
coin.approve(app.address, 0)
