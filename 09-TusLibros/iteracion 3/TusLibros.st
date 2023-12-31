!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 18:24:57'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 20:04:14'!
invalidUserOrPasswordError
	^'Invalid user or password error'! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 19:53:06'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:07:37'!
test01InvalidUserOrPasswordCannotCreateInterface

	| interface password userID |
	
	interface := Interface withValidator: [:anUser :aPassword  | ^self error: self invalidUserOrPasswordError] withCatalog: testObjectsFactory defaultCatalog.
	
	self should: [ 
		interface createCartWithUser: userID withPassword: password. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText equals: self invalidUserOrPasswordError.]
	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:33:10'!
test02ValidAuthenticationCreatesCart

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	 
	self assert: (interface listCart: idCart ) equals: '0'.
	
	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:07:37'!
test03CannotListInvalidIDCart

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	 
	self should: [(interface listCart: 3 ) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Interface invalidIdCartError]
	
	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:36:59'!
test04ListCartWith2ItemsPrintsValidTicket

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	interface addToCart: idCart withISBN: testObjectsFactory itemSellByTheStore withQuantity: 2.
	
	self assert: (interface listCart: idCart) equals: ('0|validBook|2').
	
	
	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 16:58:11'!
test05ListCartWithDIfferentItemsPrintsValidTicket

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	
	interface addToCart: idCart withISBN: testObjectsFactory itemSellByTheStore withQuantity: 2.
	interface addToCart: idCart withISBN: testObjectsFactory anotherItemSellByTheStore withQuantity: 1.
	
	self assert: (interface listCart: idCart) equals: ('0|validBook|2|validBook2|1').
	
	
	
	
	
	
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/8/2023 01:32:34'!
test06CannotAddToCartInvalidItems

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	
	self should: [interface addToCart: idCart withISBN: testObjectsFactory itemNotSellByTheStore withQuantity: 2.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: Interface invalidItemError.
				self assert: (interface listCart: idCart) equals: ('0').].
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/8/2023 01:33:26'!
test07CannotAddToCartInvalidQuantityOfItems

	| interface idCart |
	
	interface := Interface withValidator: [:anUser :aPassword  | ] withCatalog: testObjectsFactory defaultCatalog.
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	
	self should: [interface addToCart: idCart withISBN: testObjectsFactory itemSellByTheStore withQuantity: -1.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: Interface invalidAmountOfItems.
				self assert: (interface listCart: idCart) equals: ('0').].
	
	! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 20:49:14'!
test08CheckoutCartWithInvalidCreditCardDoesNotProcess

	| interface idCart |
	
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	interface := Interface 
				withValidator: [:anUser :aPassword  | ] 
				withCatalog: testObjectsFactory defaultCatalog 
				withMerchantProcessor: self
				forDate: testObjectsFactory today.
				
	idCart := interface createCartWithUser: 'user1' withPassword: 'password1'.
	
	interface addToCart: idCart withISBN: testObjectsFactory itemSellByTheStore withQuantity: 1.
	
	
	self should: [interface checkoutCart: idCart withCreditCard: testObjectsFactory notExpiredCreditCard . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Interface invalidCardError.
							     self assert: (interface listPurchasesFor: 'user1' withPassword: 'password1') equals: ('0|0').	]
	
	
	
	
	
	
	
	
	
	
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items userID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'cc 11/7/2023 21:35:19'!
initializeAcceptingItemsOf: aCatalog withUserID: aUserID 
	catalog := aCatalog.
	userID := aUserID.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:36:09'!
printTicket
	| ticket temp |
	ticket := '0'.
	temp := items asSet.
	temp do: [:anItem | ticket :=  ticket , '|' ,  anItem , '|',  (self occurrencesOf: anItem)  asString  ].
	^ticket.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 21:34:58'!
acceptingItemsOf: aCatalog withUserID: aUserID 
	^self new initializeAcceptingItemsOf: aCatalog withUserID: aUserID.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'authenticatorValidator totalCreatedCarts catalog createdCarts cardValidator today authValidator_CHANGE_ME interfaceTest date transactionsRegister totalTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'initialization' stamp: 'cc 11/6/2023 21:13:00'!
initializeWithValidator: anAuthenticatorValidator withCatalog: aCatalogue  
	authenticatorValidator := anAuthenticatorValidator.
	catalog := aCatalogue .
	totalCreatedCarts := 0.
	createdCarts := Dictionary new.! !

!Interface methodsFor: 'initialization' stamp: 'cc 11/7/2023 21:39:38'!
initializeWithValidator: authValidator withCatalog: aCatalog withMerchantProcessor: anInterfaceTest forDate: aDate 
	
	authenticatorValidator := authValidator.
	cardValidator := anInterfaceTest .
	catalog := aCatalog .
	today := aDate.
	
	transactionsRegister := Dictionary new.
	createdCarts := Dictionary new.
	
	totalCreatedCarts := 0.
	totalTransactions := 0.! !


!Interface methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 21:39:49'!
addToCart: idCart withISBN: anISBN withQuantity: aQuantity
 	
	(createdCarts at: idCart) add: aQuantity of: anISBN.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 21:43:15'!
checkoutCart: idCart withCreditCard: aCreditCard 
	
	| cartForCheckout salesBook cashier |
	cartForCheckout := createdCarts at: idCart.
	salesBook := OrderedCollection new.
	
	cashier := Cashier 
			toCheckout: cartForCheckout 
			charging: aCreditCard
			throught: cardValidator
			on:  today
			registeringOn:  salesBook.
			
	cashier checkOut.
	
	totalTransactions := totalTransactions +1.
	transactionsRegister add: totalTransactions -> salesBook.
	
	^totalTransactions.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 21:34:23'!
createCartWithUser: userID withPassword: password 
	| newCart |
	authenticatorValidator value: userID value: password.
	
	newCart := Cart acceptingItemsOf: catalog withUserID: userID.
	totalCreatedCarts := totalCreatedCarts + 1. 
	
	createdCarts add: totalCreatedCarts -> newCart.
	
	^totalCreatedCarts.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:34:39'!
listCart: idCart 
	idCart >  totalCreatedCarts ifTrue: [^self error: Interface invalidIdCartError ]. 
	^(createdCarts at: idCart) printTicket.! !

!Interface methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 21:39:38'!
listPurchasesFor: aUserID withPassword: userPassword 
	| userPurchases |
	userPurchases := transactionsRegister at: aUserID.
	^userPurchases.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!


!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/8/2023 01:34:11'!
invalidAmountOfItems
	^'Invalid number of items'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 20:49:59'!
invalidCardError
	^Cashier creditCardHasNoCreditErrorMessage.! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 20:50:53'!
invalidIdCartError
	^'Invalid cart error'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 16:47:49'!
invalidItemError
^'Item is not in catalog'
	! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 16:53:08'!
invalidItemErrorMessage
	^'Item not in catalog'! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/6/2023 21:08:49'!
withValidator: anAuthenticatorValidator withCatalog: aCatalog
	^self new initializeWithValidator: anAuthenticatorValidator withCatalog: aCatalog! !

!Interface class methodsFor: 'as yet unclassified' stamp: 'cc 11/7/2023 18:26:03'!
withValidator: authValidator withCatalog: aCatalog withMerchantProcessor: anInterfaceTest forDate: aDate 
	^self new initializeWithValidator: authValidator 
			withCatalog:  aCatalog
			withMerchantProcessor: anInterfaceTest
			forDate: aDate! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'cc 11/6/2023 21:39:37'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'cc 11/7/2023 16:58:46'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStore ;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
