!classDefinition: #EditorialStoreTest category: 'TusLibros'!
TestCase subclass: #EditorialStoreTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EditorialStoreTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/2/2023 21:41:38'!
test09CartCalculatesTotalCartAmount

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	cart add: self anotherItemSellByTheStore withOcurrences: 1.
	self assert: cart calculateOrderAmount equals: 13! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/3/2023 13:11:06'!
test10EmptyCartCannotCheckOut
	|cart|
	cart := self createCart.
	
	self should: [Cashier with: cart.] raise: Error - MessageNotUnderstood withExceptionDo: [:anError | self assert: anError messageText equals: Cashier emptyCartErrorMessage ]! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/3/2023 01:23:29'!
test11CustomerNameShouldNotBeEmpty
	
	self should: [ CreditCard for: self anInvalidCustomerName 
						withNumberCC: self aValidNumberOfCreditCard 
						withExpirationDate: self aValidExpirationDate.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CreditCard invalidCustomerName ]
	! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/3/2023 11:56:01'!
test12IdCardContainsSixteenDigits
	
	self should: [ CreditCard for: self validCustomerName 
							withNumberCC: self invalidShortCreditCardId 
						withExpirationDate: self aValidExpirationDate.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CreditCard invalidSizeCreditCardID ]
	! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/3/2023 12:53:05'!
test13IdCardCannotContainLettersAndSpaces
	
	self should: [ CreditCard for: self validCustomerName 
							withNumberCC: self invalidDigitsCreditCardId 
						withExpirationDate: self aValidExpirationDate.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: CreditCard invalidDigitCreditCardID ]
	! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'CJF 11/3/2023 13:25:29'!
test14CashierRejectsCreditCardExpired
	| cart creditCard |
	cart := 	self createCart.
	cart add: self itemSellByTheStore withOcurrences: 2.
	creditCard := CreditCard for: self validCustomerName withNumberCC: self aValidNumberOfCreditCard  withExpirationDate: self anInvalidExpirationDate.
	
	self should: [ Cashier for: cart with: creditCard ] 
		raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier creditCardExpired].! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'camila 11/6/2023 01:42:11'!
test15paymentCannotAppliedWithCreditCardWIthNoCredit

	| merchantProcessor cart cashier creditCard |
	cart := 	self createCart.
	cart add: self itemSellByTheStore withOcurrences: 2.
	
	creditCard := CreditCard for: self validCustomerName withNumberCC: self aValidNumberOfCreditCard  withExpirationDate: self aValidExpirationDate.
	cashier := Cashier for: cart with: creditCard.
	
	merchantProcessor := MerchantProcessor new.
	
	self should: [ cashier checkout: merchantProcessor ] 
		raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
			self assert: anError messageText equals: MerchantProcessor creditCardHasNoCredit].
		! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'camila 11/6/2023 01:43:19'!
test16paymentCannotAppliedWithStolenCreditCard

	| merchantProcessor cart cashier creditCard |
	cart := 	self createCart.
	cart add: self itemSellByTheStore withOcurrences: 2.
	
	creditCard := CreditCard for: self validCustomerName withNumberCC: self aValidNumberOfCreditCard  withExpirationDate: self aValidExpirationDate.
	creditCard transferAmount: 100.
	creditCard steal.
	
	cashier := Cashier for: cart with: creditCard.
	
	merchantProcessor := MerchantProcessor new.
	
	self should: [ cashier checkout: merchantProcessor ] 
		raise: Error - MessageNotUnderstood withExceptionDo: [:anError | 
			self assert: anError messageText equals: MerchantProcessor creditCardIsStolen].
	! !

!EditorialStoreTest methodsFor: 'tests' stamp: 'camila 11/6/2023 01:42:48'!
test17ValidCreditCardValidCartDoesCheckout
| merchantProcessor cart cashier creditCard checkoutResult |
	cart := 	self createCart.
	cart add: self itemSellByTheStore withOcurrences: 2.
	
	creditCard := CreditCard for: self validCustomerName withNumberCC: self aValidNumberOfCreditCard  withExpirationDate: self aValidExpirationDate.
	creditCard transferAmount: 100.
	
	cashier := Cashier for: cart with: creditCard.
	
	merchantProcessor := MerchantProcessor new.
	
	checkoutResult := cashier checkout: merchantProcessor.
	self assert: (checkoutResult = '0|OK').! !


!EditorialStoreTest methodsFor: 'support' stamp: 'camila 11/6/2023 01:18:10'!
aValidExpirationDate
	^December of: 2024.! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/2/2023 21:51:07'!
aValidNumberOfCreditCard
	^'1234567891234567'! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/3/2023 14:50:16'!
anInvalidExpirationDate
	^October of: 2023.! !

!EditorialStoreTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/2/2023 21:29:54'!
defaultCatalog

	^Dictionary with: self itemSellByTheStore -> 5 with: self anotherItemSellByTheStore -> 3.! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/3/2023 11:58:43'!
invalidDigitsCreditCardId
	^'1 04586a89654745'! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/3/2023 01:34:34'!
invalidShortCreditCardId
	^'123456789123456'! !

!EditorialStoreTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!EditorialStoreTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !

!EditorialStoreTest methodsFor: 'support' stamp: 'CJF 11/3/2023 01:33:42'!
validCustomerName
	^'Hola Mundo'! !


!EditorialStoreTest methodsFor: 'as yet unclassified' stamp: 'CJF 11/2/2023 21:50:39'!
anInvalidCustomerName
	^''! !

!EditorialStoreTest methodsFor: 'as yet unclassified' stamp: 'CJF 11/2/2023 21:30:19'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'CJF 11/2/2023 21:32:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
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


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'xxxxx' stamp: 'CJF 11/2/2023 21:41:17'!
calculateOrderAmount
	|total|
	total := 0.
	catalog keysDo: [ :anItem | total := total +  ((catalog at: anItem ) * (items occurrencesOf: anItem ))  ].
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart catalogPrice cart_CHANGE_ME creditCard_CHANGE_ME creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'CJF 11/3/2023 14:02:14'!
initializeFor: aCart with: aCreditCard 
	cart := aCart.
	creditCard := aCreditCard.! !

!Cashier methodsFor: 'initialization' stamp: 'CJF 11/2/2023 18:53:27'!
initializeWith: aCart andPrice: aCatalogPrice 
	cart := aCart.
	catalogPrice := aCatalogPrice.! !


!Cashier methodsFor: 'category-name' stamp: 'CJF 11/2/2023 19:10:20'!
calculateOrderAmount
	|total|
	total:=0.
	catalogPrice keysDo: [ :anItem | total := total +  (catalogPrice at: anItem ) * (cart occurrencesOf: anItem ) ].
	^total.! !

!Cashier methodsFor: 'category-name' stamp: 'CJF 11/2/2023 19:52:39'!
checkOutFor: aCustomerName with: aCreditCardNumber withExpirtacionDate: anExpirationDate 

	aCustomerName ifEmpty: [ ^self error: Cashier invalidCostumerName ].
	
	(aCreditCardNumber size < 16)  ifTrue: [ ^self error: Cashier invalidNumberCreditCard ].
	
	aCreditCardNumber do: [ :aChar |  (aChar isLetter or: aChar isSeparator ) ifTrue: [ ^self error: Cashier invalidNumberCreditCard ] ].! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:38:21'!
checkout: merchantProcessor 
	^merchantProcessor debit: cart calculateOrderAmount from: creditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'CJF 11/2/2023 18:37:10'!
emptyCartErrorMessage
	^'Cart cannot be empty'! !

!Cashier class methodsFor: 'instance creation' stamp: 'CJF 11/3/2023 14:51:25'!
for: aCart with: aCreditCard 
	(aCart isEmpty) ifTrue: [ ^self error: Cashier emptyCartErrorMessage ].
	(aCreditCard isExpired: self actualMonthAndYear) ifTrue: [ ^self error: Cashier creditCardExpired ].
	^self new initializeFor: aCart with: aCreditCard ! !

!Cashier class methodsFor: 'instance creation' stamp: 'CJF 11/2/2023 18:36:18'!
with: cart 
	(cart isEmpty) ifTrue: [ ^self error: Cashier emptyCartErrorMessage ].
	^self new initializeWith: cart ! !

!Cashier class methodsFor: 'instance creation' stamp: 'CJF 11/2/2023 18:52:34'!
with: cart andPrice: catalogPrice 
	(cart isEmpty) ifTrue: [ ^self error: Cashier emptyCartErrorMessage ].
	^self new initializeWith: cart andPrice: catalogPrice ! !


!Cashier class methodsFor: 'errorsMessages' stamp: 'CJF 11/3/2023 14:59:26'!
creditCardExpired
	^'Credit Card expired'! !

!Cashier class methodsFor: 'errorsMessages' stamp: 'CJF 11/2/2023 19:26:45'!
invalidCostumerName
	^'Invalid costumer name error'! !

!Cashier class methodsFor: 'errorsMessages' stamp: 'CJF 11/2/2023 19:30:35'!
invalidNumberCreditCard
	^'Invalid number of credit card'! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:18:32'!
actualMonthAndYear
	^November of: 2023
! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'customerName creditCardNumber expirationDate creditCardAmount customer amount isStolen'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'camila 11/6/2023 01:41:30'!
initializeFor: aCustomerName withNumberCC: aCreditCardNumber withExpirationDate: anExpirationDate 
	
	customerName := aCustomerName.
	creditCardNumber := aCreditCardNumber.
	expirationDate := anExpirationDate.
	amount := 0.
	isStolen := false.! !


!CreditCard methodsFor: 'queries' stamp: 'CJF 11/3/2023 14:58:39'!
isExpired: monthAndYear 
	^expirationDate < monthAndYear! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:30:41'!
hasCredit
	^ amount > 0.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:41:15'!
isStolen
	^isStolen ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:40:40'!
steal
	isStolen := true.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:39:46'!
transferAmount: anAmount 
	amount := anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messages' stamp: 'CJF 11/2/2023 21:49:17'!
invalidCustomerName
	^'Invalid customer name'! !

!CreditCard class methodsFor: 'error messages' stamp: 'CJF 11/3/2023 12:03:03'!
invalidDigitCreditCardID
	^'Credit Card ID can only contain numeric digits'! !

!CreditCard class methodsFor: 'error messages' stamp: 'CJF 11/3/2023 11:56:01'!
invalidSizeCreditCardID
	^'Credit card ID must containt 16 digit'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'CJF 11/3/2023 12:02:07'!
for: aCustomerName withNumberCC: aCreditCardNumber withExpirationDate: anExpirationDate 
	(aCustomerName = '') ifTrue: [ ^self error: CreditCard invalidCustomerName ].
	(aCreditCardNumber size = 16) ifFalse: [ ^self error: CreditCard invalidSizeCreditCardID ].
	aCreditCardNumber do:[ :aDigit | 
		(aDigit isLetter or: aDigit isSeparator ) ifTrue: 
										[ ^self error: CreditCard invalidDigitCreditCardID]
						].
	^self new initializeFor: aCustomerName withNumberCC: aCreditCardNumber withExpirationDate: anExpirationDate ! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:37:03'!
debit: anAmount from: aCreditCard 
 	(aCreditCard hasCredit) ifFalse: [^self error:  MerchantProcessor creditCardHasNoCredit.].
	(aCreditCard isStolen) ifTrue: [^self error:  MerchantProcessor creditCardIsStolen.].
	^'0|OK'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:37:22'!
creditCardHasNoCredit
	^'1|Credit card has no credit error'! !

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'camila 11/6/2023 01:37:30'!
creditCardIsStolen
	^'1|Credit card is stolen'! !
