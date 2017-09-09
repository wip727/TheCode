# The Code
		
A smart contract for creating and using tokens on Ethereum Network

## Installation

1, Install nodejs

```
sudo apt-get update

sudo apt install curl

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt-get install -y nodejs

sudo apt-get install npm
``` 

2, Install testrpc 

```
sudo apt-get install build-essential

sudo apt-get install git

sudo npm install -g ethereumjs-testrpc
```

3, Install truffle@3.4.7  (version matters!)

```
sudo npm install -g truffle@3.4.7
```

## Deployment 

1, Start terminal A, type testrpc and enter:

```
testrpc
```

2, Start terminal B, cd into TheCode/, and compile the contracts by running:

```
truffle compile
``` 

3, Still in terminal B, then migrate/deploy the contract:

```
truffle migrate
```

## Contract Execution

1, In terminal B, open up the truffle console:

```
truffle console
```

2, Save the deployed contract to a variable named 'app' 

```
TheCode.deployed().then(function(i){app = i})
```

3, View the available methods in app by pressing tab after 'app.', for example you can run the following:

```
app.name()
app.symbol();
app.totalSupply();
```
to view the basic informations of the token.  
