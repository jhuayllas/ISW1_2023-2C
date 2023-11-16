!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'testing' stamp: 'cc 11/13/2023 21:52:05'!
dataInput

	^ 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'testing' stamp: 'cc 11/13/2023 21:44:46'!
importCustomers: inputFIle

	"
	self importCustomers
	"
	| inputStream  newCustomer line |

	"inputStream := UniFileStream new open: inputFIle forWrite: false."
	inputStream := ReadStream on: inputFIle .

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].


	inputStream close.
	! !

!ImportTest methodsFor: 'testing' stamp: 'cc 11/13/2023 21:47:00'!
test01Import

	| numberOfCustomers |
	
	self importCustomers: self dataInput.

	numberOfCustomers := (session selectAllOfType: Customer) size.
	
	self assert: numberOfCustomers equals: 2.
	
	! !

!ImportTest methodsFor: 'testing' stamp: 'cc 11/13/2023 21:47:10'!
test02PepeSanchezAndHisAddressesAddedCorrectly

	| numberOfCustomers customer customers customerAddresses |
	
	self importCustomers: self dataInput.
	
	numberOfCustomers := (session selectAllOfType: Customer) size.
	self assert: numberOfCustomers equals: 2.
	
	customers := session select: [:aCustomer  | 
						aCustomer identificationType = 'D' 
						and: [aCustomer identificationNumber ='22333444']]
						ofType: Customer.
				
	self assert: customers size equals: 1.
	
	customer := customers anyOne.
	self assert: customer firstName equals: 'Pepe'.
	self assert: customer lastName equals: 'Sanchez'.
	
	customerAddresses := customer addresses.
	self assert:  customerAddresses size equals: 2.
			
	self assert: (customerAddresses includes: self pepeSanchezFirstAddress ).
	self assert: (customerAddresses includes: self pepeSanchezSecondAddress ) .

	! !

!ImportTest methodsFor: 'testing' stamp: 'cc 11/13/2023 21:47:17'!
test03JuanPerezAndHisAddressesAddedCorrectly

	| numberOfCustomers customer customers customerAddresses |
	
	self importCustomers: self dataInput.
	
	numberOfCustomers := (session selectAllOfType: Customer) size.
	self assert: numberOfCustomers equals: 2.
	
	customers := session select: [:aCustomer  | 
							aCustomer identificationType = 'C' 
							and: [aCustomer identificationNumber ='23-25666777-9']]
							ofType: Customer.
				
	self assert: customers size equals: 1.
	
	customer := customers anyOne.
	self assert: customer firstName equals: 'Juan'.
	self assert: customer lastName equals: 'Perez'.
	
	customerAddresses := customer addresses.
	self assert:  customerAddresses size equals: 1.
	
	self assert: (customerAddresses includes: self juanPerezFirstAddress ).

	! !


!ImportTest methodsFor: 'variables' stamp: 'cc 11/13/2023 21:39:14'!
juanPerezFirstAddress
	
	| firstAddress |
	firstAddress := Address new.
	firstAddress streetName: 'Alem'.
	firstAddress streetNumber: 1122 .
	firstAddress town: 'CABA'.
	firstAddress zipCode: 1001.
	firstAddress province: 'CABA'.
	
	^firstAddress.! !

!ImportTest methodsFor: 'variables' stamp: 'cc 11/13/2023 21:41:50'!
pepeSanchezFirstAddress

	| firstAddress |
	firstAddress := Address new.
	firstAddress streetName: 'San Martin'.
	firstAddress streetNumber: 3322 .
	firstAddress town: 'Olivos'.
	firstAddress zipCode: 1636.
	firstAddress province: 'BsAs'.
	
	^firstAddress ! !

!ImportTest methodsFor: 'variables' stamp: 'cc 11/13/2023 21:41:10'!
pepeSanchezSecondAddress

| secondAddress |
secondAddress := Address new.
	secondAddress streetName: 'Maipu'.
	secondAddress streetNumber: 888 .
	secondAddress town: 'Florida'.
	secondAddress zipCode: 1122 .
	secondAddress province: 'Buenos Aires'.
	
	^secondAddress.! !


!ImportTest methodsFor: 'set up' stamp: 'cc 11/13/2023 20:30:51'!
setUp

	"super setUp a veces"
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'set up' stamp: 'cc 11/13/2023 20:33:03'!
tearDown

	session commit.
	session close! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'cc 11/13/2023 21:26:19'!
= anObject
	^(self province = anObject  province )
		and: [self streetName = anObject streetName]
		and: [self streetNumber = anObject streetNumber]
		and: [self town = anObject  town]
		and: [self zipCode = anObject zipCode].! !

!Address methodsFor: 'as yet unclassified' stamp: 'cc 11/13/2023 21:24:54'!
== anObject
	^(self province == anObject  province )
		and: [self streetName == anObject streetName]
		and: [self streetNumber == anObject streetNumber]
		and: [self town == anObject  town]
		and: [self zipCode == anObject zipCode].! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
