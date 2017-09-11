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
		//Log events
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
		ledger.approve(owner[item], depositValue[item]);
		borrower[item] = msg.sender;
		startTime[item] = now;
		//Log event
		ItemBorrowed(item, msg.sender, startTime[item]);
		return true;
	} 



}