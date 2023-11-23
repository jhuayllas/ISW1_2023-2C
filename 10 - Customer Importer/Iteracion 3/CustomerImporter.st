!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:33:47'!
test01Import

	CustomerImporter valueFrom: self validImportData into: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:32'!
test02CustomerRecordsHasLessThanFiveFields
	
	self should: [  CustomerImporter valueFrom: self customerRecordWithFourFieldsInRow into: system.  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter dataCustomerMustHaveFiveFields.
			self assert: 0 equals: ( system selectAllOfType: Customer) size ].! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:40'!
test03CustomerRecordsHasMoreThanFiveFields
	
	self should: [  CustomerImporter valueFrom: self customerRecordWithSixFieldsInRow into: system.  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter dataCustomerMustHaveFiveFields.
			self assert: 0 equals: ( system selectAllOfType: Customer) size ].! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:48'!
test04AddressRecordsHasLessThanSixFields
	
	self should: [  CustomerImporter valueFrom: self addressRecordWithFiveFieldsInRow into: system .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter dataAddressMustHaveSixFields.
			self assert: 1 equals: (system selectAllOfType: Customer) size ].! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:50'!
test05AddressRecordsHasMoreThanSixFields
	
	self should: [  CustomerImporter valueFrom: self addressRecordWithSevenFieldsInRow into: system .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter dataAddressMustHaveSixFields.
			self assert: 1 equals: ( system selectAllOfType: Customer) size ].! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:54'!
test06FirstLetterMustRepresentACustomerOrAddress
	
	self should: [  CustomerImporter valueFrom: self dataWithFirstValueInvalid into: system .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter firstFieldsMustBeCorA.
			self assert: 0 equals: ( system selectAllOfType: Customer) size ].! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:37:57'!
test07firstRecordMustBeCustomer
	
	self should: [  CustomerImporter valueFrom: self dataWithNoCustomers into: system .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter firstRecordMustBeCustomer.
			self assert: 0 equals: ( system selectAllOfType: Customer) size ].
		
		! !

!ImportTest methodsFor: 'tests' stamp: 'CJF 11/22/2023 20:38:01'!
test08FirstFieldMustContainSingleCharacters
	
	self should: [  CustomerImporter valueFrom: self dataWithNoSingleFields into: system .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [  :anError | 
			self assert: anError messageText equals: CustomerImporter firstFieldsMustBeCorA .
			self assert: 0 equals: ( system selectAllOfType: Customer) size ].
		
		! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'CJF 11/22/2023 20:21:45'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber



"	^ (system session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne".

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'CJF 11/22/2023 20:15:14'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (system selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'CJF 11/22/2023 22:33:27'!
setUp

	"system := TransientCustomerSystem new."
	system := Enviroment current createCustomerSystem.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'CJF 11/22/2023 20:06:17'!
tearDown

	system  commit.
	system  close.
	! !



!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 19:55:25'!
addressRecordWithFiveFieldsInRow
		^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 20:02:04'!
addressRecordWithSevenFieldsInRow
^ ReadStream on:
	'C,Pepe,Sanchez,D,22333444
A,San,Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 19:53:51'!
customerRecordWithFourFieldsInRow
	^ ReadStream on:
'C,PepeSanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 19:54:10'!
customerRecordWithSixFieldsInRow
	^ ReadStream on:
'C,Pepe,Sanchez,D,2233,3444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/20/2023 18:41:33'!
dataWithFirstRecordWithEmptyFields
	
	^ ReadStream on:
'C,,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 20:08:24'!
dataWithFirstValueInvalid
	
	^ ReadStream on:
'Z,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/16/2023 20:17:55'!
dataWithNoCustomers
		^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/20/2023 18:36:28'!
dataWithNoSingleFields
		^ ReadStream on:
'cC,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'system readStream line newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'CJF 11/22/2023 20:36:18'!
initializeFrom: aReadStream into: aSystem
	system := aSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 20:02:37'!
assertAddressRecortMustHaveSixFields

	(self lineData size < 6) ifTrue: [ self error: CustomerImporter dataAddressMustHaveSixFields ].
		(self lineData size > 6) ifTrue: [ self error: CustomerImporter dataAddressMustHaveSixFields ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:51:40'!
assertCustomerRecordMustHaveFiveFields

	(self lineData size <5) 
			ifTrue: [ self error: CustomerImporter dataCustomerMustHaveFiveFields ].
		( self lineData size >5)
			ifTrue: [ self error: CustomerImporter dataCustomerMustHaveFiveFields ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 20:02:37'!
importAddressRecord
		
		self assertAddressRecortMustHaveSixFields.
		
		newAddress := Address new.
		newCustomer addAddress: newAddress.
		newAddress streetName: (self lineData) second.
		newAddress streetNumber: (self lineData) third asNumber .
		newAddress town: (self lineData) fourth.
		newAddress zipCode: (self lineData) fifth asNumber .
		newAddress province: (self lineData) sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/22/2023 20:36:18'!
importCustomerRecord
		
		self assertCustomerRecordMustHaveFiveFields.
		
		newCustomer := Customer new.
		newCustomer firstName: (self lineData) second.
		newCustomer lastName: (self lineData) third.
		newCustomer identificationType: (self lineData) fourth.
		newCustomer identificationNumber: (self lineData) fifth.
		system persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 20:30:10'!
importRecord
	self assertValidFirstFields.
	(self isCostumerRecord) ifTrue: [ 
		self importCustomerRecord 
		].
	(self isAddressRecord) ifTrue: [ 
		self importAddressRecord 
		].
	
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:23:01'!
isAddressRecord

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:23:12'!
isCostumerRecord

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:33:48'!
lineData

	^ line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:28:20'!
newRecordAvaliable

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'CJF 11/16/2023 19:28:40'!
value

	[self newRecordAvaliable ] 
		whileTrue: [
		self importRecord.].

	! !


!CustomerImporter methodsFor: 'as yet unclassified' stamp: 'CJF 11/20/2023 18:45:50'!
assertValidFirstFields
	| customerFieldEvaluation addressFiedsEvaluation retEvaluation|
	
	self lineData do: [ :field | field ifEmpty: [ self error: CustomerImporter emptyFieldsInRecord]  ].
	
	(self lineData first = 'A' and: [ newCustomer isNil ]) ifTrue: 
						[ self error: CustomerImporter firstRecordMustBeCustomer].
	
	customerFieldEvaluation := self lineData first = 'C'.
	addressFiedsEvaluation := self lineData first = 'A'.
	retEvaluation := customerFieldEvaluation or: addressFiedsEvaluation .
	
	retEvaluation ifFalse: [self error: CustomerImporter firstFieldsMustBeCorA ].
	
	"( ( self lineData beginsWith: 'C') or: [ self lineData beginsWith: 'A'] ) ifFalse: [self error: CustomerImporter firstFieldsMustBeCorA ]."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error Messages' stamp: 'CJF 11/16/2023 19:55:53'!
dataAddressMustHaveSixFields
	^'address record must have six fields'! !

!CustomerImporter class methodsFor: 'error Messages' stamp: 'CJF 11/16/2023 19:50:20'!
dataCustomerMustHaveFiveFields
	^' Fields must have five fields '! !

!CustomerImporter class methodsFor: 'error Messages' stamp: 'CJF 11/20/2023 18:41:58'!
emptyFieldsInRecord
	^'Empty fields in record'! !

!CustomerImporter class methodsFor: 'error Messages' stamp: 'CJF 11/16/2023 20:23:22'!
firstFieldsMustBeCorA
	^'invalid first field record'! !

!CustomerImporter class methodsFor: 'error Messages' stamp: 'CJF 11/16/2023 20:18:21'!
firstRecordMustBeCustomer
	^' first record must be customer '! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 20:46:14'!
beginTransaction

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 20:46:28'!
commit

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'evaluating' stamp: 'CJF 11/22/2023 20:46:41'!
initializeSession

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'persistance' stamp: 'CJF 11/22/2023 20:46:46'!
persist: aNewCustomer

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'closing' stamp: 'CJF 11/22/2023 20:46:22'!
close

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 20:46:32'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 20:46:50'!
selectAllOfType: customerClass

	self subclassResponsibility! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 20:04:26'!
beginTransaction
	session beginTransaction .! !

!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 20:06:33'!
commit.
	session commit 	! !


!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'CJF 11/22/2023 20:01:11'!
initialize
	super initialize .
	self initializeSession .! !

!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'CJF 11/22/2023 19:54:52'!
initializeSession

	session := DataBaseSession for: (Array with: Address with: Customer)! !


!PersistentCustomerSystem methodsFor: 'persistance' stamp: 'CJF 11/22/2023 20:37:17'!
persist: aNewCustomer 
	session persist: aNewCustomer.! !


!PersistentCustomerSystem methodsFor: 'closing' stamp: 'CJF 11/22/2023 20:06:42'!
close
	session close	! !


!PersistentCustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 20:20:08'!
customerWithIdentificationType: anIdType number: anIdNumber
	^(session select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 20:13:41'!
selectAllOfType: customerClass
	^session selectAllOfType: customerClass! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 20:58:55'!
beginTransaction
	! !

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'CJF 11/22/2023 21:09:39'!
commit
	! !


!TransientCustomerSystem methodsFor: 'initialization' stamp: 'CJF 11/22/2023 20:57:02'!
initialize
	customers := OrderedCollection new.! !


!TransientCustomerSystem methodsFor: 'persistance' stamp: 'CJF 11/22/2023 20:59:38'!
persist: aNewCustomer 
	customers add: aNewCustomer ! !


!TransientCustomerSystem methodsFor: 'closing' stamp: 'CJF 11/22/2023 21:09:51'!
close
	! !


!TransientCustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 21:09:13'!
customerWithIdentificationType: anIdType number: anIdNumber 
		^(customers select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ] and: [ aCustomer isKindOf: Customer]]) anyOne! !

!TransientCustomerSystem methodsFor: 'selecting' stamp: 'CJF 11/22/2023 21:05:15'!
selectAllOfType: aType 
	^customers select: [ :aCustomer | aCustomer isKindOf: aType ].! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'CJF 11/22/2023 19:57:36'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'CJF 11/22/2023 19:57:31'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Enviroment category: 'CustomerImporter'!
Object subclass: #Enviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Enviroment methodsFor: 'enviroment creation' stamp: 'CJF 11/22/2023 22:44:12'!
createCustomerSystem

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enviroment class' category: 'CustomerImporter'!
Enviroment class
	instanceVariableNames: ''!

!Enviroment class methodsFor: 'instance creation' stamp: 'CJF 11/22/2023 22:37:19'!
current
	^self allSubclasses 
			detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]
			ifFound: [ :anEnvironmentClass | anEnvironmentClass new]
			ifNone: [ self error: 'No environment found' ]! !


!Enviroment class methodsFor: 'category-name' stamp: 'CJF 11/22/2023 22:44:04'!
isCurrent

	self subclassResponsibility! !


!classDefinition: #DevelopmentEnviroment category: 'CustomerImporter'!
Enviroment subclass: #DevelopmentEnviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnviroment methodsFor: 'enviroment creation' stamp: 'CJF 11/22/2023 22:42:03'!
createCustomerSystem
	^TransientCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnviroment class' category: 'CustomerImporter'!
DevelopmentEnviroment class
	instanceVariableNames: ''!

!DevelopmentEnviroment class methodsFor: 'category-name' stamp: 'CJF 11/22/2023 22:40:15'!
isCurrent
	^IntegrationEnviroment isCurrent not.! !


!classDefinition: #IntegrationEnviroment category: 'CustomerImporter'!
Enviroment subclass: #IntegrationEnviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnviroment methodsFor: 'enviroment creation' stamp: 'CJF 11/22/2023 22:41:09'!
createCustomerSystem
	^PersistentCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnviroment class' category: 'CustomerImporter'!
IntegrationEnviroment class
	instanceVariableNames: ''!

!IntegrationEnviroment class methodsFor: 'category-name' stamp: 'CJF 11/22/2023 22:41:30'!
isCurrent
	^false! !
