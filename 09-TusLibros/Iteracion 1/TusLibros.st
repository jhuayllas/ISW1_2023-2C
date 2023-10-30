!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:08:54'!
test01CartStartsEmpty
	|cart|
	cart := Cart withEditorialList: {}.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:15:36'!
test02AddOneBookToCart
	|cart|
	cart := Cart withEditorialList: self editorialListWithOneValidISBN . 
	cart add: self aValidISBNOne quantity: 1.
	self deny: (cart isEmpty). ! !

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:15:55'!
test03ListBooksInShopList
	| cart |
	cart := Cart withEditorialList: self editorialListWithTwoValidISBN.
	cart add: self aValidISBNOne quantity: 1.
	cart add: self aValidISBNTwo quantity: 1.
	
	self deny: cart isEmpty.
	self assert: cart listShopList equals: self editorialListWithTwoValidISBN .! !

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:15:36'!
test04AddBooksWithQuantity
	| cart |
	cart := Cart withEditorialList: (self editorialListWithOneValidISBN).
	cart add: self aValidISBNOne quantity: 2.
	
	self deny: cart isEmpty.
	self assert: cart listShopList equals: (OrderedCollection  with:self aValidISBNOne with: self aValidISBNOne).! !

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:16:31'!
test05OnlyAddISBNFromThisEditorial
	| cart |
	cart := Cart withEditorialList: {self aValidISBNOne}. 
	
	
	self should: [cart add: self anInvalidISBN quantity: 1 .] 
		raise: Error - MessageNotUnderstood  withExceptionDo: [  :anError| 
			self assert: anError messageText equals: Cart invalidISBNIdentifier.
			self assert: cart isEmpty.].! !

!CartTest methodsFor: 'tests' stamp: 'CJF 10/30/2023 20:15:36'!
test06QuantityMustBeGreaterThanZero
	| cart |
	cart := Cart withEditorialList: {self aValidISBNOne}. 
	
	
	self should: [cart add: self aValidISBNOne quantity: -1 .] 
		raise: Error - MessageNotUnderstood  withExceptionDo: [  :anError| 
			self assert: anError messageText equals: Cart invalidQuantityValue.
			self assert: cart isEmpty.].! !


!CartTest methodsFor: 'ISBN codes' stamp: 'CJF 10/30/2023 20:15:36'!
aValidISBNOne

	^ #aValidISBN! !

!CartTest methodsFor: 'ISBN codes' stamp: 'CJF 10/30/2023 20:15:55'!
aValidISBNTwo

	^ #aValidISBN2! !

!CartTest methodsFor: 'ISBN codes' stamp: 'CJF 10/30/2023 20:16:31'!
anInvalidISBN

	^ #anInvalidISBN! !

!CartTest methodsFor: 'ISBN codes' stamp: 'CJF 10/30/2023 20:15:36'!
editorialListWithOneValidISBN

	^ OrderedCollection with: self aValidISBNOne! !

!CartTest methodsFor: 'ISBN codes' stamp: 'CJF 10/30/2023 20:15:55'!
editorialListWithTwoValidISBN

	^ OrderedCollection with:self aValidISBNOne with: self aValidISBNTwo! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'shopList editorialList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'intialization' stamp: 'CJF 10/30/2023 19:42:39'!
initializeWithEditorialList: anEditorialList 
	shopList := OrderedCollection new.
	editorialList := anEditorialList.! !


!Cart methodsFor: 'list' stamp: 'CJF 10/30/2023 19:19:44'!
isEmpty
	^shopList isEmpty ! !

!Cart methodsFor: 'list' stamp: 'CJF 10/30/2023 19:23:09'!
listShopList
	^shopList copy.! !


!Cart methodsFor: 'adding' stamp: 'CJF 10/30/2023 20:11:47'!
add: anISBNBook quantity: aQuantity 
	self assertValidateISBN: anISBNBook andQuantity: aQuantity .
	shopList add: anISBNBook  withOccurrences: aQuantity .! !


!Cart methodsFor: 'assertions' stamp: 'CJF 10/30/2023 20:12:16'!
assertValidateISBN: anISBNBook andQuantity: aQuantity 
	(editorialList includes: anISBNBook ) ifFalse: [ ^self error: Cart invalidISBNIdentifier ].
	( aQuantity <1) ifTrue: [ ^self error: Cart invalidQuantityValue ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'CJF 10/30/2023 19:45:36'!
invalidISBNIdentifier
	^'Cannot add book with invalid ISBN identifier'! !

!Cart class methodsFor: 'instance creation' stamp: 'CJF 10/30/2023 20:07:45'!
invalidQuantityValue
	^'Invalid quantity value'! !

!Cart class methodsFor: 'instance creation' stamp: 'CJF 10/30/2023 19:42:14'!
withEditorialList: anEditorialList 

	^self new initializeWithEditorialList: anEditorialList ! !
