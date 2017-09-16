pragma solidity ^0.4.13;

/* Import basic token APIs */
import './TheCode.sol';


contract ItemBank {
	/* Public and private variables of the contract */
	address private admin;

	/* Creates mappings of items and owners */
	mapping (address => address) public owner;
	/* Creates mappings of items and borrower */
	mapping (address => address) public borrower;
	/* Creates mappings of items and borrowing time allowed */
	mapping (address => uint256) public borrowTime;
	/* Creates mappings of items and DepositValue */
	mapping (address => uint256) public depositValue;
	/* Creates mappings of items and charge rate (per second) */
	mapping (address => uint256) public borrowChargeRate;
	/* Creates mappings of items and borrowing start time */
	mapping (address => uint256) public startTime;

	/* Events to be logged on state change */
	event ItemRegistered(address indexed item, address indexed owner);
	event ItemPublished(address indexed item, uint256 time, uint256 value, uint256 rate);
	event ItemBorrowed(address indexed item, address indexed borrower, uint256 startTime);

	/* Contract constructor */
	function ItemBank() {
		admin = msg.sender;
	}

	/* Function access modifier for contract */
	modifier onlyBy(address _account) {
		require(msg.sender == _account);
		_;
	}

	/* Item registration, only can be called by admin */
	// Input arguments:
	// item, address of the item
	// itemOwner, address of the item owner
	// itemValue, a deposit for the item, must be uint type
	// itemRate, a charge rate for borrowing the item (token per second), must be uint type
	function registerItem(
		address item,
		address itemOwner,
		uint256 itemTime,
		uint256 itemValue,
		uint256 itemRate 
		)
	onlyBy(admin) returns (bool success) {
		owner[item] = itemOwner;
		borrowTime[item] = itemTime;
		depositValue[item] = itemValue;
		borrowChargeRate[item] = itemRate;
		// Log the events
		ItemRegistered(item, itemOwner);
		ItemPublished(item, itemTime, itemValue, itemRate);
		return true;
	}

	/* Item borrowing start */
	// Input arguments:
	// tokenContract, contract address of the token for using payment methods
	// item, address of the item
	function borrowItem(address tokenContract, address item) returns (bool success) {
		// TODO: add state check for item 
		// item must be registered and published and unborrowed

		TheCode ledger = TheCode(tokenContract);
		
		// uint256 deposit = depositValue[item];
		
		//// Confirm the deposit process is initiated
		// require(deposit <= ledger.allowance(tx.origin, this));
		//// Execute the deposit
		// ledger.transferFrom(tx.origin, this, deposit);
		
		// TODO: deposit status check 
		if (true) {
			// ledger.approve(owner[item], deposit);
			borrower[item] = tx.origin;
			startTime[item] = now;
			// Log the event
			ItemBorrowed(item, tx.origin, startTime[item]);
			return true;
		}
	}

	/* Item returning start */
	// Input arguments:
	// tokenContract, contract address of the token for using payment methods
	// item, address of the item
	function returnItem(address tokenContract, address item) returns (bool success) {
		TheCode ledger = TheCode(tokenContract);
		uint256 deposit = depositValue[item];
		uint256 timeElapsed;
		uint256 totalCost;

		// Stop the clock and calculate the cost 
        timeElapsed = now - startTime[item];
        totalCost = timeElapsed * borrowChargeRate[item];

        if (totalCost > deposit || timeElapsed > borrowTime[item]) {
        	ledger.transfer(owner[item], deposit);
        } else {
        	ledger.transfer(owner[item], totalCost);
        	ledger.transfer(borrower[item], deposit - totalCost);
        }

        // TODO: reset a bunch of states
        delete borrower[item];
        return true;
    }
}