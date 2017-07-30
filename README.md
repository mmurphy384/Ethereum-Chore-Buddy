# Ethereum-Chore-Buddy

##Latest Revision: 
04/07/17 - MM - Created repo, added readme.md and first pass at contracts.

# Overview
The chore-buddy is a semi-fictitious contract to help in my understanding of Ethereum.  Parents will use this contract to define a list of avaiable chores, along with a number of 'tokens' that each chore is worth.  Children will have their own addresses and will self-create a User within the contract.  As they complete chores, the chore-buddy will maintain a 'balance-due' of tokens.  At any point in time, the children can withdraw their tokens and redeem them for real cash (the old-fashioned way . .. until I find a way to turn etherum into USD).  The contract is made up of:
  * A 'Users' contract/library which holds the childrens nickname, their current balance and their wallet address.
  * A 'Chores' contract/library which holds the list of available chores (including amount of tokens per chore). The parent adds these.
  * A 'Tracker' contract which will import the Users and Chores contract and will provide a useable gateway to add/manage users and chores and token redemption.



  # Current Questions
Thus far, I've created the Users, Chores, and Tracker contracts. But they are not usable in any way.  I'm going to mostly focus on getting the "Users" contract up and running first.  At this point, I have some very rudimentary functions in place and a basic test for the Users contract will pass.  I'd like to build this out fully, and apply the same patterns and techniques to the Chores contract.

Once I get the "Users" and "Chores" contracts finalized, I can start pulling them into the "Tracker" contract.  Dumb question:  I'm not sure if the "Users" and "Chores" cotnracts should be defined as a 'library' instead. I'm not even sure I understand the difference.

Within the Users contract, I'm trying to support a few difficult features and it's painting me into a crappy corner.  For example, I would like to be able to generate a list of users.  I don't believe it's possible to loop through a 'mapping', so I decided to use an array of Users. This allows me to loop through the 2 dimensional array (to hold nickname and balances), and return two 1 dimensional arrays for 'nickname' and 'balances'.  In my research, I've read that returning arrays of strings isn't really practical, so I used Bytes (based on a video I watched).  If you look at how I have to process the arrays in the GetUsers, it's apparent I'm headed down a bad path. It just looks ugly and I think I'm going to have all kinds of problems working in bytes in Ethereum and strings in javascript.  On top of all of this, I realized that for security reasons, I would prefer to do all lookups by an address.  As such, I put a mapping (address ==> uint) to link an address to an index in the users array.  In the end, the whole thing feels like a gigantic mess.  I haven't added anymore functions because I need to get this sorted out.  On the good news front, I do have a functioning test for the "Users" contract.

I'm having a tough time deciding what should be in the contract and what should be maintained elsewhere.  The notion of storing 'user-accounts' in a contract is causing me to think through how all of this comes together, because I don't want to have a user-account collection with names, contact info, etc . .. . . .gobbling up all that gas.  But I don't really know how to reconcile it in a real-world way.  Is it best to let the contract have all of it's info, or should I rely on having a nodejs app that is doing the account management, etc.
