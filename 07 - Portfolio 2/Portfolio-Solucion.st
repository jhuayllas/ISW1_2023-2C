!classDefinition: #Tests category: 'Portfolio-Solucion'!
TestCase subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
Tests subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
Tests subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Tests subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #ReportTests category: 'Portfolio-Solucion'!
Reports subclass: #ReportTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test01ReportForNewReceptiveAccountPrintBalanceZero
	| anAccount summaryReport|
	anAccount := ReceptiveAccount new. 
	summaryReport  := AccountSummary for: anAccount.
	
	self assert: (summaryReport buildResult) equals: (OrderedCollection with: 'Balance = 0').! !

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test02ReportForReceptiveAccountWithDepositPrintDespositValue
	| anAccount reportPrinted summaryReport |
	anAccount := ReceptiveAccount new. 
	Deposit register: 100 on: anAccount.
	
	summaryReport := AccountSummary for: anAccount .
	reportPrinted := OrderedCollection with:'Balance = 100' with: 'Depósito por 100.'.
	
	self assert: (summaryReport buildResult) equals: reportPrinted.! !

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test03ReportForReceptiveAccountWithWithdrawPrintWithdrawValue
	| anAccount reportPrinted summaryReport |
	anAccount := ReceptiveAccount new. 
	Withdraw register: 50 on: anAccount.
	summaryReport := AccountSummary for: anAccount.
	reportPrinted := OrderedCollection with:'Balance = -50' with: 'Extracción por 50.'.
	self assert: (summaryReport buildResult) equals: reportPrinted.! !

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test04ReportForAccountWithMultipleAccounTransactionPrintAllAndBalance
	| anAccount reportPrinted summaryReport|
	anAccount := ReceptiveAccount new. 
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	summaryReport := AccountSummary for: anAccount .
	
	reportPrinted := OrderedCollection with:'Balance = 50' with: 'Depósito por 100.' with: 'Extracción por 50.'.
	self assert: (summaryReport buildResult) equals: reportPrinted.! !

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test05ReportPrintTransferOutput
	| originAccount originReport  receiverAccount receiverReport summaryOriginReport summaryReceiverReport |
	originAccount := ReceptiveAccount new. 
	receiverAccount := ReceptiveAccount new.
	Transfer from: originAccount to: receiverAccount withValue: 20.
	
	summaryOriginReport := AccountSummary for: originAccount .
	summaryReceiverReport := AccountSummary for: receiverAccount .
	
	originReport := OrderedCollection with:'Balance = -20' with: 'Salida por transferencia de 20.'.
	receiverReport := OrderedCollection with: 'Balance = 20' with: 'Entrada por transferencia de 20.'.
	self assert: (summaryOriginReport buildResult ) equals: originReport.
	self assert: (summaryReceiverReport buildResult ) equals: receiverReport.! !

!ReportTests methodsFor: 'tests' stamp: 'camila 10/25/2023 20:55:18'!
test06ReportPrintAllTransactions
	| anAccount originReport  summaryReport|
	anAccount := ReceptiveAccount new. 
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	Transfer from: anAccount to: ReceptiveAccount new withValue: 20.
	Transfer from: ReceptiveAccount new to: anAccount withValue: 30.
	summaryReport := AccountSummary for: anAccount .
	
	originReport := OrderedCollection with:'Balance = 60' 
								with: 'Depósito por 100.' 
								with:'Extracción por 50.' 
								with: 'Salida por transferencia de 20.' 
								with: 'Entrada por transferencia de 30.'.
								
	self assert: (summaryReport buildResult) equals: originReport.
	! !


!classDefinition: #TransferNetTests category: 'Portfolio-Solucion'!
Reports subclass: #TransferNetTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test01TransferNetReportForNewAccountReturnZero
	|anAccount transferReport |
	anAccount := ReceptiveAccount new. 
	transferReport := TransferNet for: anAccount .
	self assert: (transferReport buildResult) equals: 0.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test02TransferNetReportForAccountWithReceiverTransfer
	|anAccount transferReport|
	anAccount := ReceptiveAccount new. 
	Transfer from: ReceptiveAccount new to: anAccount  withValue: 20.
	transferReport := TransferNet for: anAccount .
	self assert: (transferReport buildResult) equals: 20.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test03TransferNetReportForAccountWithOriginTransfer
	|anAccount transferReport|
	anAccount := ReceptiveAccount new. 
	Transfer from: anAccount to: ReceptiveAccount new  withValue: 20.
	transferReport := TransferNet for: anAccount .
	self assert: (transferReport buildResult) equals: -20.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test04TransferNetReportWithDepositAndWithdrawDoesNotAffectTransferNetTotal
	|anAccount transferReport |
	anAccount := ReceptiveAccount new. 
	Transfer from: anAccount to: ReceptiveAccount new  withValue: 20.
	Transfer from: ReceptiveAccount new to: anAccount withValue: 30.
	Deposit register: 10 on: anAccount .
	Withdraw register: 20 on: anAccount .
	transferReport  := TransferNet for: anAccount .
	self assert: (transferReport buildResult )equals: 10.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test05TransferNetReportWithMultipleTransferReturnSumOfThem
	|anAccount transferReport|
	anAccount := ReceptiveAccount new. 
	Transfer from: anAccount to: ReceptiveAccount new  withValue: 20.
	Transfer from: ReceptiveAccount new to: anAccount withValue: 30.
	transferReport := TransferNet for: anAccount .
	self assert: (transferReport buildResult) equals: 10.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test06TransferNetReportWithDeposit
	|anAccount transferReport |
	anAccount := ReceptiveAccount new. 
	Deposit register: 10 on: anAccount .
	transferReport  := TransferNet for: anAccount .
	self assert: (transferReport buildResult )equals: 0.! !

!TransferNetTests methodsFor: 'test' stamp: 'camila 10/25/2023 20:55:18'!
test07TransferNetReportWithWithdraw
	|anAccount transferReport |
	
	anAccount := ReceptiveAccount new. 
	
	Withdraw register: 20 on: anAccount .
	
	transferReport  := TransferNet for: anAccount .
	self assert: (transferReport buildResult )equals: 0.! !


!classDefinition: #TransfersTests category: 'Portfolio-Solucion'!
Tests subclass: #TransfersTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransfersTests methodsFor: 'tests' stamp: 'CJF 10/19/2023 21:21:24'!
test01TransferBetweenAccountsAffectBalances
	| originAccount receiverAccount  transfer |
	originAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new. 
	
	transfer := Transfer from: originAccount to: receiverAccount withValue: 50.
	
	self assert: originAccount balance equals: -50.
	self assert: receiverAccount balance equals: 50.! !

!TransfersTests methodsFor: 'tests' stamp: 'CJF 10/24/2023 16:16:35'!
test02AccountsRegisterTransfer
	| originAccount receiverAccount  transfer |
	originAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new. 
	
	transfer := Transfer from: originAccount to: receiverAccount withValue: 50.
	self assert: ( transfer isOrigin: originAccount ).
	self assert: ( transfer isReceiver: receiverAccount ).
	"self assert: (originAccount hasRegistered: transfer).
	self assert: (receiverAccount hasRegistered: transfer)."! !

!TransfersTests methodsFor: 'tests' stamp: 'CJF 10/24/2023 16:26:09'!
test03TransferMustNotBeNegative
	| originAccount receiverAccount  |
	originAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new. 
	self should: [
			Transfer from: originAccount to: receiverAccount withValue: -50.] 
		raise: Error withExceptionDo: [ :anError |
				self assert: anError messageText equals: Transfer invalidTransferValueError.
				self assert: originAccount balance equals: 0.
				self assert: receiverAccount balance equals: 0.
			]! !

!TransfersTests methodsFor: 'tests' stamp: 'CJF 10/24/2023 16:26:14'!
test04TransferBetweenDifferentAccount
	| anAccount |
	anAccount := ReceptiveAccount new.
	self should: [ Transfer from: anAccount to: anAccount  withValue: 50 ]
		raise: Error withExceptionDo: [ :anError |
				self assert: anError messageText equals: Transfer sameAccountError.
				self assert: anAccount balance equals: 0.
			 ]! !

!TransfersTests methodsFor: 'tests' stamp: 'CJF 10/24/2023 16:40:21'!
test05NavigationBetweenTransferLegs
	| originAccount receiverAccount transfer origin receiver|
	originAccount := ReceptiveAccount new. 
	receiverAccount := ReceptiveAccount new. 
	
	transfer := Transfer from: originAccount to: receiverAccount withValue: 50.
	
	origin := transfer originTransfer.
	receiver := transfer receiverTrasnfer. 
	
	self assert: (origin isContraryTransfer: receiver).
	self assert: (receiver isContraryTransfer: origin). ! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'CJF 10/23/2023 21:52:01'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction |
			(transaction isKindOf: OriginTransfer ) ifTrue: [transaction affectBalance: currentBalance].
			(transaction isKindOf: ReceiverTransfer ) ifTrue: [transaction affectBalance: currentBalance ]
				ifFalse:[
			transaction affectBalance: currentBalance]
		 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'functionality' stamp: 'camila 10/25/2023 21:05:24'!
startFunctionalityResult: anAccountFunctionality 
	transactions do: [ :aTransaction | aTransaction executeFunctionality: anAccountFunctionality].
! !


!classDefinition: #AccountFunctionality category: 'Portfolio-Solucion'!
Object subclass: #AccountFunctionality
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountFunctionality methodsFor: 'initialization' stamp: 'camila 10/25/2023 21:01:21'!
initializeFor: anAccount

	self subclassResponsibility! !


!AccountFunctionality methodsFor: 'execute' stamp: 'camila 10/25/2023 20:27:37'!
executeForDeposit: aDeposit

	self subclassResponsibility! !

!AccountFunctionality methodsFor: 'execute' stamp: 'camila 10/25/2023 20:27:46'!
executeForOriginTransfer: anOriginTransfer

	self subclassResponsibility! !

!AccountFunctionality methodsFor: 'execute' stamp: 'camila 10/25/2023 20:27:54'!
executeForReceiverTransfer: aReceiverTransfer

	self subclassResponsibility! !

!AccountFunctionality methodsFor: 'execute' stamp: 'camila 10/25/2023 20:28:01'!
executeForWithdraw: aWithdraw

	self subclassResponsibility! !


!AccountFunctionality methodsFor: 'result' stamp: 'camila 10/25/2023 20:55:18'!
buildResult

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountFunctionality subclass: #AccountSummary
	instanceVariableNames: 'result'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'camila 10/25/2023 21:01:39'!
initializeFor: anAccount

	account := anAccount .
	result := OrderedCollection new.! !


!AccountSummary methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:34'!
executeForDeposit: aDeposit 
	result addLast: 'Depósito por ' , aDeposit value asString, '.'. ! !

!AccountSummary methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:38'!
executeForOriginTransfer: anOriginTransfer 
	result addLast: 'Salida por transferencia de ' , anOriginTransfer value asString , '.'! !

!AccountSummary methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:27'!
executeForReceiverTransfer: aReceiverTransfer 
	result addLast: 'Entrada por transferencia de ' , aReceiverTransfer value asString , '.'.! !

!AccountSummary methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:30'!
executeForWithdraw: aWithdraw 
	result addLast: 'Extracción por ' , aWithdraw value asString , '.'! !


!AccountSummary methodsFor: 'result' stamp: 'camila 10/25/2023 21:08:01'!
buildResult
	result addLast: 'Balance = ' , (account balance asString ). 
	account startFunctionalityResult: self.
	^result.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'CJF 10/24/2023 17:42:37'!
for: anAccount 
	^self new initializeFor: anAccount ! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountFunctionality subclass: #TransferNet
	instanceVariableNames: 'result'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'camila 10/25/2023 21:01:54'!
initializeFor: anAccount

	account := anAccount .
	result := 0.! !


!TransferNet methodsFor: 'execute' stamp: 'camila 10/25/2023 21:02:59'!
executeForDeposit: aDeposit 
	result := result + 0.! !

!TransferNet methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:04'!
executeForOriginTransfer: anOriginTransfer 
	result := result - (anOriginTransfer value).! !

!TransferNet methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:12'!
executeForReceiverTransfer: aReceiverTransfer 
	result := result + (aReceiverTransfer value).! !

!TransferNet methodsFor: 'execute' stamp: 'camila 10/25/2023 21:03:18'!
executeForWithdraw: aWithdraw 
	result := result + 0.! !


!TransferNet methodsFor: 'result' stamp: 'camila 10/25/2023 21:08:07'!
buildResult
	account startFunctionalityResult: self.
	^result.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'CJF 10/24/2023 20:41:04'!
for: anAccount 
	^self new initializeFor: anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'camila 10/25/2023 20:40:11'!
value

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'camila 10/25/2023 20:39:53'!
affectBalance: aBalance

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'report' stamp: 'camila 10/25/2023 21:12:27'!
executeFunctionality: anAccountFuncionality

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'initialization' stamp: 'camila 10/25/2023 20:40:05'!
initializeFor: aValue

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'camila 10/25/2023 21:06:20'!
executeFunctionality: anAccountFuncionality 
	anAccountFuncionality executeForDeposit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #OriginTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #OriginTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OriginTransfer methodsFor: 'initialize' stamp: 'camila 10/25/2023 20:54:03'!
initializeFor: aTransfer 
	transfer := aTransfer.! !


!OriginTransfer methodsFor: 'balance' stamp: 'CJF 10/23/2023 21:56:46'!
affectBalance: currentBalance 
	^currentBalance - 	(transfer value )! !


!OriginTransfer methodsFor: 'report' stamp: 'camila 10/25/2023 21:09:49'!
executeFunctionality: anAccountFuncionality 
	anAccountFuncionality executeForOriginTransfer: self. ! !


!OriginTransfer methodsFor: 'value' stamp: 'CJF 10/24/2023 16:44:02'!
value
	^ transfer value! !


!OriginTransfer methodsFor: 'transferVerification' stamp: 'CJF 10/24/2023 16:39:02'!
isContraryTransfer: pata 
	^transfer receiverTrasnfer = pata.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginTransfer class' category: 'Portfolio-Solucion'!
OriginTransfer class
	instanceVariableNames: ''!

!OriginTransfer class methodsFor: 'instance creation' stamp: 'camila 10/25/2023 20:54:03'!
withTransfer: aTransfer
	^self new initializeFor: aTransfer ! !


!classDefinition: #ReceiverTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #ReceiverTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceiverTransfer methodsFor: 'initialize' stamp: 'camila 10/25/2023 20:53:34'!
initializeFor: aTransfer 
	transfer := aTransfer.! !


!ReceiverTransfer methodsFor: 'balance' stamp: 'CJF 10/23/2023 21:57:44'!
affectBalance: currentBalance 
	^currentBalance + (transfer value)! !


!ReceiverTransfer methodsFor: 'report' stamp: 'camila 10/25/2023 21:10:18'!
executeFunctionality: anAccountFuncionality 
	anAccountFuncionality executeForReceiverTransfer: self. ! !


!ReceiverTransfer methodsFor: 'value' stamp: 'CJF 10/24/2023 16:43:54'!
value
	^ transfer value! !


!ReceiverTransfer methodsFor: 'transferVerification' stamp: 'CJF 10/24/2023 16:39:30'!
isContraryTransfer: pata 
	^transfer originTransfer = pata.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceiverTransfer class' category: 'Portfolio-Solucion'!
ReceiverTransfer class
	instanceVariableNames: ''!

!ReceiverTransfer class methodsFor: 'instance creation' stamp: 'camila 10/25/2023 20:53:34'!
withTransfer: aTransfer 
	^self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'camila 10/25/2023 21:09:01'!
executeFunctionality: anAccountFuncionality 
	anAccountFuncionality executeForWithdraw: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'originTransfer receiverTransfer transferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialize' stamp: 'CJF 10/24/2023 16:24:51'!
initializeFrom: anOriginAccount to: aReceiverAccount withValue: aTransferValue 
	(aTransferValue > 0) ifFalse: [ ^self error: Transfer invalidTransferValueError ].
	( anOriginAccount = aReceiverAccount ) ifTrue: [ ^self error: Transfer sameAccountError ] "hacer un assert"
.	originTransfer := OriginTransfer withTransfer: self.
	anOriginAccount register: originTransfer.
	receiverTransfer := ReceiverTransfer withTransfer: self.
	aReceiverAccount register: receiverTransfer .
	transferValue := aTransferValue.
! !


!Transfer methodsFor: 'balance' stamp: 'CJF 10/24/2023 16:05:00'!
affectBalance: currentBalance from: aReceptiveAccount 
	(aReceptiveAccount = originTransfer ) ifTrue: [ ^(currentBalance - transferValue ) ].
	^currentBalance + transferValue .! !


!Transfer methodsFor: 'pata' stamp: 'CJF 10/24/2023 16:05:12'!
isPataDestino: anAccount 
	^receiverTransfer = anAccount ! !

!Transfer methodsFor: 'pata' stamp: 'CJF 10/24/2023 16:05:00'!
isPataOrigen: anAccount 
	^originTransfer = anAccount ! !

!Transfer methodsFor: 'pata' stamp: 'CJF 10/22/2023 19:43:43'!
pataOrigen
	self shouldBeImplemented.! !


!Transfer methodsFor: 'value' stamp: 'CJF 10/22/2023 21:05:26'!
value
	^transferValue ! !


!Transfer methodsFor: 'category-name' stamp: 'CJF 10/24/2023 16:23:34'!
isOrigin: originAccount 
	^originAccount hasRegistered: originTransfer.! !

!Transfer methodsFor: 'category-name' stamp: 'CJF 10/24/2023 16:24:11'!
isReceiver: receiverAccount 
	^receiverAccount hasRegistered: receiverTransfer .! !

!Transfer methodsFor: 'category-name' stamp: 'CJF 10/24/2023 16:37:25'!
originTransfer
	^originTransfer! !

!Transfer methodsFor: 'category-name' stamp: 'CJF 10/24/2023 16:37:44'!
receiverTrasnfer
	^receiverTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'CJF 10/24/2023 16:11:27'!
from: originAccount to: receiverAccount withValue: transferValue 
	|transfer|
	transfer := self new initializeFrom: originAccount to: receiverAccount withValue: transferValue .
	"originAccount register: (OriginTransfer withTransfer: transfer).
	receiverAccount register: (ReceiverTransfer withTransfer: transfer)."
	^transfer.! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'CJF 10/22/2023 19:51:52'!
invalidTransferValueError
	^ 'Transferencia must be positve'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'CJF 10/22/2023 20:15:08'!
sameAccountError
	^' No es posible transferir entre la misma cuenta '! !
