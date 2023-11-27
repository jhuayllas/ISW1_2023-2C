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
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

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

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'CJF 11/27/2023 15:14:58'!
setUp
	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'CJF 11/26/2023 23:59:29'!
singleCustomer

	^ ReadStream on:
'C,Juan,Perez,D,5456774
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:53:23'!
assertJuanPerezOsSupplierClient
	^(system supplierWithIdentificationType: 'D' number: '123') includesClient: self juanPerezCustomer.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:54:09'!
assertMaipu888IsSupplierAddres
	^( system supplierWithIdentificationType: 'D' number: '123' ) includesAddress: self alemAddress.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/23/2023 20:03:16'!
assertNewCustomerIsPepeSanchez
	|newSupplier|
	newSupplier := system customerWithIdentificationType: 'D' number: '123'.
	self assert: (newSupplier hasCustomer:( Customer named: 'Pepe' withLastName: 'Sanchez' identificationType: 'D'  indentificationNumber: '22333444' ) )! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:53:02'!
assertPepeSanchezIsSupplierClientAndNewCustomer
	^(system supplierWithIdentificationType: 'D' number: '123') includesClient: self pepeSanchezClient.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:53:59'!
assertSanMartin3322IsSupplierAddress
	^(system supplierWithIdentificationType: 'D' number: '123' ) includesAddress: self sanMartinAddress.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 08:15:04'!
assertSupplierHasNoClients
	|importedSupplier|
	importedSupplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: importedSupplier numberOfCustomers equals: 0.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:53:41'!
assertSupplierHasTwoAddresses
	|importedSupplier|
	importedSupplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: importedSupplier numberOfAddresses equals: 2.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:52:49'!
assertSupplierHasTwoClients

	^(( (system supplierWithIdentificationType: 'D' number: '123') numberOfCustomers ) = 2)! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 07:51:10'!
assertSupplierImportedCorrectly
	|importedSupplier|
	"importedSupplier := system customerWithIdentificationType: 'D' number: '123'."
	importedSupplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: 'Supplier1' equals: importedSupplier name. 
! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 15:15:34'!
test01validInputImportCorrectly
	CustomerImporter valueFrom: self singleCustomer into: system.

	SupplierImporter valueFrom: self validSupplierRecords into: system.
	
	self assert: 1 equals: system numberOfSuppliers.
	self assertSupplierImportedCorrectly.
	self assertSupplierHasTwoClients.
	self assertPepeSanchezIsSupplierClientAndNewCustomer.
	self assertJuanPerezOsSupplierClient.
	self assertSupplierHasTwoAddresses.
	self assertSanMartin3322IsSupplierAddress.
	self assertMaipu888IsSupplierAddres.! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 01:52:16'!
test02supplierMustHaveOnlyFourFields
	self should:[
	SupplierImporter valueFrom: (ReadStream on: 'S,,D,123') into: system.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: SupplierImporter supplierRecordNumberFieldsErrorMessage.
		]
! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 01:52:27'!
test03supplierRecordMustStartWithSingleS
	self should: [	
	SupplierImporter valueFrom: (ReadStream on: 'SS, Supplier1,D,123') into: system. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter supplierRecordMustStartWithS.
		 ]! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 01:52:33'!
test04newCustomerInSupplierEntryMustNotExistInCustomersSystem
	CustomerImporter valueFrom: (ReadStream on: 'C,Juan,Perez,C,23-25666777-9') into: system.
	
	self should: [
		SupplierImporter valueFrom: self supplierWithOneNewCustomer into: system.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
			self assert: anError messageText equals: SupplierImporter newCustomerAlreadyExistInSystem.
			self assertSupplierHasNoClients.
		].! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 01:52:38'!
test05supplierWithExistingCustomerMustExistInSystem
	
	self should: [
		SupplierImporter valueFrom: self suplierWithEC into: system.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
			self assert: anError messageText equals: SupplierImporter existingCustomerDoesNotExists.
			self assertSupplierHasNoClients.
		].! !

!ImportTest methodsFor: 'tests - supplier' stamp: 'CJF 11/27/2023 01:52:44'!
test06supplierAddressesMustContainSixFieldsInRecord
	
	self should: [
		SupplierImporter valueFrom: self suplierWithInvalidAddress into: system.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
			self assert: anError messageText equals: SupplierImporter invalidSupplierAddressesFields.
		].! !


!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/27/2023 00:54:33'!
alemAddress
	^Address withStreetName: 'Alem' streetNumber: 1122 town: 'CABA'  zipCode: '1001'  province: 'CABA'! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/27/2023 00:31:52'!
juanPerezCustomer
	^Customer named: 'Juan' withLastName: 'Perez' identificationType: 'D' indentificationNumber: '5456774'! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/27/2023 00:23:13'!
pepeSanchezClient
	^Customer named: 'Pepe' withLastName: 'Sanchez' identificationType: 'D' indentificationNumber: '22333444' ! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/27/2023 00:44:57'!
sanMartinAddress
	^Address withStreetName: 'San Martin' streetNumber: 3322 town: 'Olivos'  zipCode: '1636' province: 'BsAs'! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/23/2023 20:45:31'!
suplierWithEC
	^ReadStream on: 
	'S,Supplier1,D,123
EC,D,22333444'! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/26/2023 20:55:49'!
suplierWithInvalidAddress
	^ReadStream on: 
	'S,Supplier1,D,123
A,San Martin,,Olivos,1636,BsAs'

! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/26/2023 22:48:37'!
supplierWithOneNewCustomer
	^ReadStream on:  'S,Supplier1,D,123
NC,Juan,Perez,C,23-25666777-9'

! !

!ImportTest methodsFor: 'test supplier - data' stamp: 'CJF 11/26/2023 22:46:05'!
validSupplierRecords
	^ReadStream on:
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,5456774
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !


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


!Address methodsFor: 'initialization' stamp: 'CJF 11/23/2023 21:13:04'!
initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !


!Address methodsFor: 'comparison' stamp: 'CJF 11/27/2023 00:50:24'!
= anObject
	(self isKindOf: anObject class) ifTrue: [
		^streetName = anObject streetName and: [ streetNumber = anObject streetNumber ] and: [ town = anObject town ] and: [ zipCode = anObject zipCode ] and:[ province = anObject province ]
		].
	^false.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'CJF 11/23/2023 21:12:40'!
withStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	^self new initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:14:14'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'CJF 11/27/2023 07:45:02'!
includes: newSupplierCustomer 
	^( session selectAllOfType: newSupplierCustomer class ) includes: newSupplierCustomer ! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'CJF 11/27/2023 07:47:50'!
numberOfSuppliers
	^(session selectAllOfType: Suplier) size! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'CJF 11/27/2023 07:59:29'!
selectAllOfType: aType 
	^session selectAllOfType: aType .! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'CJF 11/27/2023 07:52:01'!
supplierWithIdentificationType: anIdType number: anIdNumber 
		^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Suplier) anyOne! !


!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'CJF 11/27/2023 02:22:13'!
start

	session := DataBaseSession for: (Array with: Address with: Customer with: Suplier ).
	! !

!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:21:06'!
start

	customers := OrderedCollection new! !

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:23:17'!
stop

	customers := nil! !


!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'CJF 11/27/2023 08:20:50'!
supplierWithIdentificationType: aType number: aNumber 
	^( customers select: [ :aCustomer | aCustomer isKindOf: Suplier] )anyOne ! !


!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'CJF 11/26/2023 20:49:19'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]] ifNone: [ self error: 'un error' ]! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'CJF 11/23/2023 20:58:16'!
numberOfCustomers

	^(customers select: [ :aCustomer | aCustomer class == Customer ]) size! !


!TransientCustomerSystem methodsFor: 'category-name' stamp: 'CJF 11/23/2023 20:33:03'!
numberOfSuppliers
	^(customers select: [ :aCustomer | aCustomer isKindOf: Suplier ]) size! !

!TransientCustomerSystem methodsFor: 'category-name' stamp: 'CJF 11/27/2023 01:46:16'!
selectAllOfType: aType 
	^customers select: [ :aCustomer | aCustomer isKindOf: aType ]	! !


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

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
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


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:38:39'!
createCustomerSystem

	^TransientCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'CJF 11/23/2023 18:23:47'!
isCurrent

	
	"self makeCurrent"
	
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:40:48'!
createCustomerSystem

	^PersistentCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #TextImporter category: 'CustomerImporter'!
Object subclass: #TextImporter
	instanceVariableNames: 'readStream system line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TextImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 20:24:12'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!TextImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 20:24:00'!
createRecord

	^ record := line findTokens: $,! !

!TextImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 20:23:51'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!TextImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 20:20:38'!
importRecord

	self subclassResponsibility! !


!TextImporter methodsFor: 'initialization' stamp: 'CJF 11/23/2023 20:23:29'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!TextImporter methodsFor: 'evaluating' stamp: 'CJF 11/23/2023 20:23:38'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextImporter class' category: 'CustomerImporter'!
TextImporter class
	instanceVariableNames: ''!

!TextImporter class methodsFor: 'importing' stamp: 'CJF 11/23/2023 20:21:55'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!TextImporter class methodsFor: 'instance creation' stamp: 'CJF 11/23/2023 20:22:29'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!TextImporter class methodsFor: 'error messages' stamp: 'CJF 11/23/2023 20:22:36'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!TextImporter class methodsFor: 'error messages' stamp: 'CJF 11/23/2023 20:22:40'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
TextImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!



!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'CJF 11/27/2023 13:59:33'!
importCustomer

	self assertValidCustomerRecord.
	newCustomer := Customer named: record second  
						withLastName:  record third
						identificationType:  record fourth 
						indentificationNumber: record fifth.
	system add: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 18:37:09'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!



!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
TextImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/26/2023 19:31:47'!
importRecord
	self assertRecordNotEmpty .
	self isSupplierRecord ifTrue: [^self importSupplier].
	self isNewCustomerRecord ifTrue: [^ self importNewCustomer].
	self isECRecord ifTrue: [ ^ self importEC ].
	self isAddressRecord ifTrue: [ ^ self importAddress ].
	
	self error: self class supplierRecordMustStartWithS! !

!SupplierImporter methodsFor: 'evaluating - private' stamp: 'CJF 11/23/2023 18:39:32'!
isSupplierRecord
	^ record first = 'S'.! !


!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/26/2023 20:57:55'!
importAddress
	|newAddress|
	(record size = 6) ifFalse: [ self error: SupplierImporter invalidSupplierAddressesFields].
	newAddress := Address withStreetName: record second streetNumber: record third asNumber town: record fourth zipCode: record fifth province: record sixth .
	newSupplier addAddress: newAddress .! !

!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/27/2023 07:42:48'!
importEC
	|customer|
	[customer := system customerWithIdentificationType: record second number: record third .] 
	on: Error do: [  :anError | self error:  SupplierImporter existingCustomerDoesNotExists  ].
	newSupplier addNewCustomer: customer. 
! !

!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/27/2023 07:43:11'!
importNewCustomer
	|newSupplierCustomer |
	newSupplierCustomer := Customer named: (record second) withLastName: (record third) identificationType: (record fourth) indentificationNumber: (record fifth) .
	( ( system selectAllOfType: Customer ) includes: newSupplierCustomer ) 
		ifTrue: [self error: SupplierImporter newCustomerAlreadyExistInSystem].
	newSupplier addNewCustomer: newSupplierCustomer .
	system add: newSupplierCustomer.! !

!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/26/2023 21:08:33'!
importSupplier
	 
	
	(record size = 4) ifFalse: [ self error: SupplierImporter supplierRecordNumberFieldsErrorMessage].
		
	newSupplier  := Suplier named: record second identificationType: record third identificationNumber: record fourth.
	system add: newSupplier.
	
! !

!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/23/2023 20:48:11'!
isECRecord
	^record first = 'EC'! !

!SupplierImporter methodsFor: 'category-name' stamp: 'CJF 11/23/2023 19:21:00'!
isNewCustomerRecord
	^record first = 'NC'! !


!SupplierImporter methodsFor: 'evaluating' stamp: 'CJF 11/23/2023 21:09:34'!
isAddressRecord
	^record first = 'A'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'error messages' stamp: 'CJF 11/26/2023 20:37:39'!
existingCustomerDoesNotExists
	^'customer does not exist in system'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'CJF 11/26/2023 20:58:23'!
invalidSupplierAddressesFields
	^'invalid address record size'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'CJF 11/26/2023 20:29:54'!
newCustomerAlreadyExistInSystem
	^'new customer already exist in system'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'CJF 11/26/2023 19:33:37'!
supplierRecordMustStartWithS
"	invalidRecordTypeErrorDescription"

	^'Invalid record type'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'CJF 11/26/2023 19:23:18'!
supplierRecordNumberFieldsErrorMessage
	^'supplier record must have four fields'! !


!classDefinition: #User category: 'CustomerImporter'!
Object subclass: #User
	instanceVariableNames: 'id identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!classDefinition: #Customer category: 'CustomerImporter'!
User subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 19:38:32'!
isAddressesEmpty

	^addresses isEmpty ! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'CJF 11/23/2023 19:59:19'!
initializeNamed: aName withLastName: aLastName identificationType: anIdType indentificationNumber: anIdNumber 
	firstName := aName.
	lastName := aLastName .
	identificationType := anIdType .
	identificationNumber := anIdNumber .! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'comparison' stamp: 'CJF 11/23/2023 20:06:35'!
= anObject
	(self isKindOf: anObject class) ifTrue: [
		^firstName = anObject firstName and: [ lastName = anObject lastName ] and: [ identificationType = anObject identificationType ] and: [ identificationNumber = anObject identificationNumber ].
		].
	^false.
	! !


!Customer methodsFor: 'as yet unclassified' stamp: 'CJF 11/27/2023 08:10:04'!
hash
	^firstName hash bitXor: (lastName hash bitXor: (identificationType hash  bitXor: (identificationNumber hash  bitXor: addresses hash ) ) )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'CJF 11/23/2023 19:57:16'!
named: aName withLastName: aLastName identificationType: anIdType indentificationNumber: anIdNumber 

	^self new initializeNamed: aName withLastName: aLastName identificationType: anIdType indentificationNumber: anIdNumber ! !


!classDefinition: #Suplier category: 'CustomerImporter'!
User subclass: #Suplier
	instanceVariableNames: 'name supplierCustomers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Suplier methodsFor: 'initialization' stamp: 'CJF 11/27/2023 15:07:22'!
initializeNamed: aName identificationType: anIdentificacionType identificationNumber: anIdentificationNumber 
	
	name := aName.
	identificationType := anIdentificacionType.
	identificationNumber := anIdentificationNumber.
	supplierCustomers := OrderedCollection new.
	addresses := OrderedCollection new.! !


!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/27/2023 15:06:24'!
addAddress: newAddress 
	addresses add: newAddress ! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/23/2023 19:59:51'!
addNewCustomer: newSupplierCustomer 
	supplierCustomers add: newSupplierCustomer .! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/23/2023 20:04:05'!
hasCustomer: aCustomer 
	^supplierCustomers includes: aCustomer! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/27/2023 15:16:13'!
identificationNumber
	^identificationNumber ! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/26/2023 21:07:49'!
identificationType
	^identificationType .! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/23/2023 19:08:02'!
name
	^name! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/23/2023 21:06:45'!
numberOfAddresses
	^addresses size! !

!Suplier methodsFor: 'as yet unclassified' stamp: 'CJF 11/23/2023 19:16:24'!
numberOfCustomers
	^supplierCustomers size.! !


!Suplier methodsFor: 'testing' stamp: 'CJF 11/27/2023 00:42:00'!
includesAddress: anAddress 
	^addresses includes: anAddress ! !

!Suplier methodsFor: 'testing' stamp: 'CJF 11/27/2023 00:24:22'!
includesClient: aCustomer 
	^supplierCustomers includes: aCustomer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Suplier class' category: 'CustomerImporter'!
Suplier class
	instanceVariableNames: ''!

!Suplier class methodsFor: 'instance creation' stamp: 'CJF 11/23/2023 18:50:24'!
named: aName identificationType: anIdentificacionType identificationNumber: anIdentificationNumber 

	^self new initializeNamed: aName identificationType: anIdentificacionType identificationNumber: anIdentificationNumber ! !
