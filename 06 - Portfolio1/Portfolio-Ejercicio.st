!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/12/2023 19:57:34'!
test01EmptyPortfolioReturnBalanceZero
	self assert: (Portfolio new) balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/12/2023 20:08:08'!
test02PortfolioWithSingleAccountReturnBalanceOfAccount
	|anAccount aPortfolio|
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount .
	self assert: (aPortfolio balance )equals: (anAccount balance )
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/12/2023 21:16:05'!
test03PortfolioWithMultipleAccountsReturnBalanceAsSumOfThem
	|firstAccount secondAccount aPortfolio|
	firstAccount := ReceptiveAccount new.
	Deposit register: 100 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Withdraw register: 50 on: secondAccount .
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: firstAccount.
	aPortfolio addAccount: secondAccount .
	
	self assert: (aPortfolio balance )equals: (firstAccount balance + secondAccount balance)
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 20:17:24'!
test04PortfolioWithAnEmptyPortfolioReturnBalanceZero
	|aPortfolio aSecondPorftfolio|
	aSecondPorftfolio := Portfolio new. 
	aPortfolio := Portfolio new. 
	
	aPortfolio addPortfolio: aSecondPorftfolio.
	
	self assert: aPortfolio balance equals: aSecondPorftfolio balance. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 20:31:06'!
test05PortfolioWithPortfolioWithAccountWithdrawReturnNoZeroBalance
	|aPortfolio aSecondPorftfolio accountWithdraw|
	accountWithdraw := ReceptiveAccount new.
	Withdraw register: 50 on: accountWithdraw .
	aSecondPorftfolio := Portfolio new. 
	aSecondPorftfolio addAccount: accountWithdraw .
	
	aPortfolio := Portfolio new. 
	aPortfolio addPortfolio: aSecondPorftfolio.
	
	self assert: (aPortfolio balance) equals: (aSecondPorftfolio balance). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 20:40:31'!
test06PortfolioWithManyPortfoliosReturnBalanceAsSumOfThem
	|aPortfolio aSecondPorftfolio aThirdPortfolio accountWithdraw accountDesposit|
	accountWithdraw := ReceptiveAccount new.
	Withdraw register: 50 on: accountWithdraw .
	
	accountDesposit := ReceptiveAccount new.
	Deposit register: 100 on: accountDesposit .
	
	aSecondPorftfolio := Portfolio new. 
	aSecondPorftfolio addAccount: accountWithdraw .
	
	aThirdPortfolio := Portfolio new.
	aThirdPortfolio addAccount: accountDesposit .
	
	aPortfolio := Portfolio new. 
	aPortfolio addPortfolio: aSecondPorftfolio.
	aPortfolio addPortfolio: aThirdPortfolio .
	
	self assert: (aPortfolio balance) equals: (aSecondPorftfolio balance) + ( aThirdPortfolio balance ). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 20:52:13'!
test07PortfolioWithAccountAndPortfolioReturnBalanceAsSumOfThem
	|aPortfolio aSecondPorftfolio  accountWithdraw accountDesposit|
	accountWithdraw := ReceptiveAccount new.
	Withdraw register: 50 on: accountWithdraw .
	
	accountDesposit := ReceptiveAccount new.
	Deposit register: 100 on: accountDesposit .
	
	aSecondPorftfolio := Portfolio new. 
	aSecondPorftfolio addAccount: accountWithdraw .
	
		
	aPortfolio := Portfolio new. 
	aPortfolio addPortfolio: aSecondPorftfolio.
	aPortfolio addAccount: accountDesposit.
		
	self assert: (aPortfolio balance) equals: (aSecondPorftfolio balance) + ( accountDesposit balance ). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:05:02'!
test08TransactionsOfEmptyPortfolioIsEmptyList
	self assert: (Portfolio new) transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:13:12'!
test09PortfolioWithSingleAccountHasSameTransactionsThanAccount
	| aPortfolio anAccount |
	
	anAccount := ReceptiveAccount new. 
	Deposit register: 100 on: anAccount .
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount .
	
	self assert: (aPortfolio transactions) equals: (anAccount transactions ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:17:11'!
test10PortfolioManyAccountsHasSameTransactionsCombined
	| aPortfolio firstAccount secondAccount alltransactions |
	
	firstAccount := ReceptiveAccount new. 
	Deposit register: 100 on: firstAccount .

	secondAccount := ReceptiveAccount new. 
	Withdraw register: 50 on: secondAccount .
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: firstAccount .
	aPortfolio addAccount: secondAccount.
	
	alltransactions := firstAccount transactions .
	alltransactions addAll: secondAccount transactions .
	
	self assert: (aPortfolio transactions) equals: alltransactions .! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:19:12'!
test11PortfolioWithdAccountAndPortfolioReturnTransactionsCombined
	| aPortfolio secondPortfolio firstAccount secondAccount alltransactions |
	
	firstAccount := ReceptiveAccount new. 
	Deposit register: 100 on: firstAccount .

	secondAccount := ReceptiveAccount new. 
	Withdraw register: 50 on: secondAccount .
	
	secondPortfolio := Portfolio new.
	secondPortfolio addAccount: secondAccount .
		
	aPortfolio := Portfolio new.
	aPortfolio addAccount: firstAccount .
	aPortfolio addPortfolio: secondPortfolio.
	
	alltransactions := firstAccount transactions .
	alltransactions addAll: secondPortfolio transactions .
	
	self assert: (aPortfolio transactions) equals: alltransactions .! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:30:40'!
test12EmptyPortfolioHasNoRegisteredTranstractions
	self deny: ((Portfolio new) hasRegistered: (Deposit register: 100 on: (ReceptiveAccount new)) ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:49:45'!
test13PortfolioWithSingleAccountHasRegisterAccountTransactions
	| aPortfolio anAccount deposit |
	anAccount := ReceptiveAccount new. 
	deposit := Deposit register: 100 on: anAccount .
	
	aPortfolio := Portfolio new. 
	aPortfolio addAccount: anAccount .
		
	self assert: (aPortfolio hasRegistered: deposit). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:55:38'!
test14PortfolioWIthPortfolioWithTransactionsHasSameTransactionsRegistered
	| aPortfolio anAccount deposit aSecondPortfolio |
	anAccount := ReceptiveAccount new. 
	deposit := Deposit register: 100 on: anAccount .
	
	aSecondPortfolio := Portfolio new.
	aSecondPortfolio addAccount: anAccount .
	
	aPortfolio := Portfolio new. 
	aPortfolio addPortfolio: aSecondPortfolio.
		
	self assert: (aPortfolio hasRegistered: deposit). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'CJF 10/13/2023 21:59:01'!
test15PortfolioWithAccountAndPortfolioHasRegisteredAllTransactions
	| aPortfolio anAccount deposit aSecondPortfolio aSecondAccount withdraw|
	anAccount := ReceptiveAccount new. 
	deposit := Deposit register: 100 on: anAccount .
	
	aSecondPortfolio := Portfolio new.
	aSecondPortfolio addAccount: anAccount .
	
	aSecondAccount := ReceptiveAccount new. 
	withdraw  :=  Withdraw register: 50 on: aSecondAccount .
	
	aPortfolio := Portfolio new. 
	aPortfolio addPortfolio: aSecondPortfolio.
	aPortfolio addAccount: aSecondAccount .	
	self assert: (aPortfolio hasRegistered: deposit). 
	self assert: (aPortfolio hasRegistered: withdraw )! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'CJF 10/9/2023 21:25:53'!
impactBalance: calculatedBalance
	^(calculatedBalance + value)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'CJF 10/9/2023 21:23:14'!
impactBalance: calculatedBalance
	^calculatedBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'CJF 10/13/2023 20:44:51'!
balance
	| accountsBalance portfoliosBalance |
	accounts isEmpty ifFalse: [
	accountsBalance := accounts  sum: [ :anAccount | anAccount balance ] ] ifTrue: [ accountsBalance  := 0].
	portfolios isEmpty ifFalse:[ portfoliosBalance := portfolios sum: [ :aPortfolio | aPortfolio balance] ] 
					ifTrue: [ portfoliosBalance := 0].
	^accountsBalance + portfoliosBalance .! !

!Portfolio methodsFor: 'balance' stamp: 'CJF 10/13/2023 20:41:30'!
initialize
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'administration' stamp: 'CJF 10/13/2023 20:29:35'!
addAccount: anAccount 
	
	accounts add: anAccount.! !

!Portfolio methodsFor: 'administration' stamp: 'CJF 10/13/2023 20:42:04'!
addPortfolio: aPortfolio
	portfolios add: aPortfolio.! !

!Portfolio methodsFor: 'administration' stamp: 'CJF 10/13/2023 22:00:14'!
hasRegistered: anAccountTransaction
	^self transactions includes: anAccountTransaction 
	"| res |
	res := false.
	accounts do: [ :anAccount  | res := res or: (anAccount hasRegistered: anAccountTransaction )  ].
	portfolios do: [ :aPortfolio | res := res or: ( aPortfolio hasRegistered: anAccountTransaction ) ].
	^res. "! !


!Portfolio methodsFor: 'transactions' stamp: 'CJF 10/13/2023 21:20:09'!
transactions
	|res|
	res := OrderedCollection new.
	accounts do:[ :anAccount | res addAll: anAccount transactions ].
	portfolios do:[ :aPortfolio | res addAll: aPortfolio transactions ].
	^res! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'CJF 10/9/2023 21:27:30'!
balance
	| balance |
	balance := 0.
	transactions do: [ :aTransaction |  balance:= aTransaction impactBalance: balance. self].
	^balance
	"^transactions sum: [ :aTransaction | aTransaction impactBalance: self
		] ifEmpty: [ 0 ]"! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
