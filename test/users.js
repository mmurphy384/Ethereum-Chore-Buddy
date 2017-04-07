contract('Users', function (accounts) {
	// This function is used to help deal with the delay associated with mining.
	// I'm not sure if I have to add this within the function or not.
	web3.eth.getTransactionReceiptMined = function (txnHash, interval) {
		var transactionReceiptAsync;
		interval = interval ? interval : 500;
		transactionReceiptAsync = function (txnHash, resolve, reject) {
			try {
				var receipt = web3.eth.getTransactionReceipt(txnHash);
				if (receipt == null) {
					setTimeout(function () {
						transactionReceiptAsync(txnHash, resolve, reject);
					}, interval);
				} else {
					resolve(receipt);
				}
			} catch (e) {
				reject(e);
			}
		};

		if (Array.isArray(txnHash)) {
			var promises = [];
			txnHash.forEach(function (oneTxHash) {
				promises.push(web3.eth.getTransactionReceiptMined(oneTxHash, interval));
			});
			return Promise.all(promises);
		} else {
			return new Promise(function (resolve, reject) {
				transactionReceiptAsync(txnHash, resolve, reject);
			});
		}
	};

	describe("Users Tests", function () {
		it("should add 2 users and then get a list of the users.", function () {
			var instance = Users.deployed();

			return Promise.all([
				// Set initial balances
				web3.eth.getBalance(instance.address),
				web3.eth.getBalance(accounts[1]),
				web3.eth.getBalance(accounts[2])
			]).then(function (results) {
				assert.equal(results[0], 0, "People contract is starting with 0 wei");
				assert.equal(results[1], 0, "Account 1 has 0 wei");
				assert.equal(results[2], 0, "Account 2 has 0 wei");
				assert.equal(instance.address, accounts[0], "People is owned by accounts[0]");
				return Promise.all([
					instance.addUser('Julian', accounts[1]),
					instance.addUser('Miranda', accounts[2])]);
			}).then(function (txn) {
				// Let it mine
				return web3.eth.getTransactionReceiptMined(txn);
			}).then(function (result) {
				// Validate it was mined and re-get the balances/amount pending withdrawal
				assert.isBelow(result.gasUsed, 3000000, "Transaction successfully mined");				
			}).catch(function (e) { 
				console.log("There was an error: " + e);
			})
		});
	});
});
