# Ethereum-Chore-Buddy

##Latest Revision: 
04/07/17 - MM - Created repo, added readme.md and first pass at contracts.

# Overview
The chore-buddy is a semi-fictitious contract to help in my understanding of Ethereum.  Parents will use thsi contract to define a list of avaiable chores, along with a number of 'tokens' that each chore is worth.  Children will create their own addresses/accounts and create a User within the contract.  As they complete chores, the chore-buddy will maintain a 'balance-due' of tokens.  At any point in time, the children can withdraw their tokens and redeem them for real cash (the old fashioned way).  The contract is made up of:
  * A Users contract/library which holds the childrens nickname, their current balance and their wallet address.
  * A Chores contract/library which holds the list of available chores (including amount of tokens per chore)
  * A Tracker contract which will import the Users and Chores contract and will provide a useable gateway to add/manage users and chores and token redemption.



  # Current Questions
Thus far, I've created the Users and Chores as contracts.  I'm not sure if they should be defined as a 'library' instead.

I'm going to mostly focus on getting the "Users" contract up and running first.  At this point, I have some very rudimentary functions in place and a basic test for the Users contract will pass.  I'd like to build this out fully, and apply the same patterns and techniques to the Chores contract.

Within the Users contract, I'm trying to support a few difficult features and it's painting me into a crappy corner.  For example, I would like to be able to generate a list of users.  I don't believe it's possible to loop through a 'mapping', so I decided to use an array of Users. This allows me to loop through the array, and generate and return arrays for 'nickname' and 'balances'.  In my research, I've read that returning arrays of strings isn't really practical, so I used Bytes (based on a video I watched).  On top of all of this, I realized that for security reasons, I would prefer to do all lookups by an address.  As such, I put a mapping (address ==> uint) to link an address to an index in the users array.  In the end, the whole thing feels like a gigantic mess.  I haven't added anymore functions because I need to get this sorted out.